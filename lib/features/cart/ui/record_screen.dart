import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../core/theming/colors.dart';
import '../logic/cubit/cart_cubit.dart';
import '../logic/videoUpload/video_upload_cubit.dart';
import '../logic/videoUpload/video_upload_state.dart';

class RecordScreen extends StatefulWidget {
  final CartCubit cartCubit;
  const RecordScreen({super.key, required this.cartCubit});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  bool _isRecordingVideo = false;
  double _progressValue = 0.0;
  Timer? _timer;
  bool _isCameraInitialized = false;
  List<CameraDescription>? _cameras;
  bool _isRearCameraSelected = true; // Track which camera is currently selected
  FlashMode _flashMode = FlashMode.off; // Track current flash mode
  XFile? _recordedVideo; // Store the recorded video file

  // Zoom related variables
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  double _baseZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      // Ensure that camera is available
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        log('No available cameras.');
        // Show error message and navigate back
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Camera not supported on this device'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          // Wait a moment before navigating back to ensure the message is seen
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
        return;
      }

      // Select the first rear camera
      final camera = _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first);

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high, // Use the highest available resolution
        enableAudio: true, // Enable audio recording
      );

      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture;

      // Get available zoom range
      if (_cameraController!.value.isInitialized) {
        try {
          _maxAvailableZoom = await _cameraController!.getMaxZoomLevel();
          _minAvailableZoom = await _cameraController!.getMinZoomLevel();
          log('Camera zoom range: $_minAvailableZoom - $_maxAvailableZoom');
        } catch (e) {
          // If getting zoom levels fails, set default values
          log('Error getting zoom range: $e');
          _minAvailableZoom = 1.0;
          _maxAvailableZoom = 5.0; // Default to 5x max zoom
        }

        // Ensure we have a valid zoom range
        if (_maxAvailableZoom <= _minAvailableZoom) {
          _minAvailableZoom = 1.0;
          _maxAvailableZoom = 5.0;
          log('Invalid zoom range detected, using defaults: 1.0-5.0');
        }

        _currentZoomLevel = 1.0;
        _baseZoomLevel = 1.0;
      }

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      log('Error initializing camera: $e');
    }
  }

  Future<void> _startVideoRecording() async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final Directory appDocumentDir = await getApplicationDocumentsDirectory();
      final String videoPath =
          path.join(appDocumentDir.path, '${DateTime.now()}.mp4');

      await _cameraController!.startVideoRecording();
      log('Recording video to: $videoPath');

      setState(() {
        _isRecordingVideo = true;
        _progressValue = 0.0; // Reset progress
      });

      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _progressValue += 0.01;
          if (_progressValue >= 1.0) {
            _stopVideoRecording();
          }
        });
      });
    } catch (e) {
      log('Error starting video recording: $e');
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_cameraController!.value.isRecordingVideo) {
      return;
    }

    try {
      XFile videoFile = await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecordingVideo = false;
        _progressValue = 1.0;
        _recordedVideo = videoFile; // Store the recorded video file
      });
      _timer?.cancel();

      // Handle the video file (e.g., save it, display it)
      log('Video recorded to ${videoFile.path}');

      // Show a notification that video is ready to send
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video recorded! Click send to upload.')),
      );
    } catch (e) {
      log('Error stopping video recording: $e');
    }
  }

  Future<void> _uploadVideo() async {
    if (_recordedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video has been recorded')),
      );
      return;
    }

    try {
      // Read the video file as bytes
      final File file = File(_recordedVideo!.path);
      final Uint8List videoBytes = await file.readAsBytes();

      // Get the filename from the path
      final String fileName = path.basename(_recordedVideo!.path);

      // Get the VideoUploadCubit instance from context and call uploadVideo
      context.read<VideoUploadCubit>().uploadVideo(videoBytes, fileName);

      // Show a loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading video...')),
      );
    } catch (e) {
      log('Error preparing video for upload: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload video: ${e.toString()}')),
      );
    }
  }

  void _switchCamera() async {
    if (_cameras == null || _cameras!.isEmpty) {
      return;
    }

    _isRearCameraSelected = !_isRearCameraSelected;
    final camera = _isRearCameraSelected
        ? _cameras!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
            orElse: () => _cameras!.first)
        : _cameras!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => _cameras!.first);

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeControllerFuture = _cameraController!.initialize();
    await _initializeControllerFuture;

    setState(() {});
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    // Only handle zoom when scale is changing
    if (details.scale != 1.0) {
      try {
        // Calculate new zoom level with proper clamping
        double newZoomLevel = (_baseZoomLevel * details.scale)
            .clamp(_minAvailableZoom, _maxAvailableZoom);

        // Only update if the zoom level actually changed to avoid unnecessary updates
        if ((_currentZoomLevel - newZoomLevel).abs() > 0.01) {
          log('Setting zoom level: $newZoomLevel (min: $_minAvailableZoom, max: $_maxAvailableZoom)');

          // Apply the new zoom level to the camera
          await _cameraController!.setZoomLevel(newZoomLevel);

          // Update the state with new zoom level
          setState(() {
            _currentZoomLevel = newZoomLevel;
          });
        }
      } catch (e) {
        log('Error setting zoom level: $e');
      }
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseZoomLevel = _currentZoomLevel;
  }

  // Method to toggle flash mode
  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    // Cycling through flash modes: off -> auto -> always (torch) -> off
    switch (_flashMode) {
      case FlashMode.off:
        _flashMode = FlashMode.auto;
        break;
      case FlashMode.auto:
        _flashMode = FlashMode.always;
        break;
      case FlashMode.always:
        _flashMode = FlashMode.off;
        break;
      default:
        _flashMode = FlashMode.off;
    }

    // Apply the flash mode to the camera
    await _cameraController!.setFlashMode(_flashMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Calculate dimensions for a camera preview that's 50% of screen height with 3:4 aspect ratio
    final double previewHeight = size.height * 0.5;
    final double previewWidth = size.width; // Use full screen width

    return BlocListener<VideoUploadCubit, VideoUploadState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (videoUrl) {
            // Update the CartCubit with the videoUrl
            widget.cartCubit.setVideoLink(videoLink: videoUrl);
            log('Video link updated in CartCubit: $videoUrl');

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Video uploaded successfully!')),
            );
            // Close the screen after successful upload
            Navigator.of(context).pop();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload failed: $message')),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _isCameraInitialized
            ? Stack(
                children: [
                  // Camera preview with full width and maintained aspect ratio
                  Center(
                    child: Container(
                      width: previewWidth,
                      height: previewHeight,
                      color: Colors.black,
                      child: GestureDetector(
                        onScaleStart: _handleScaleStart,
                        onScaleUpdate: _handleScaleUpdate,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: previewWidth,
                              height: previewHeight *
                                  (_cameraController!.value.aspectRatio),
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Overlay Buttons (positioned on top of the camera preview)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _flashMode == FlashMode.off
                                      ? Icons.flash_off
                                      : _flashMode == FlashMode.auto
                                          ? Icons.flash_auto
                                          : Icons.flash_on,
                                  color: ColorsManager.white,
                                ),
                                onPressed: _toggleFlash,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_isRecordingVideo) {
                                    _stopVideoRecording();
                                  } else {
                                    _startVideoRecording();
                                  }
                                },
                                child: SizedBox(
                                  width: 80.0,
                                  height: 80.0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80.0,
                                        height: 80.0,
                                        child: CircularProgressIndicator(
                                          value: _progressValue,
                                          strokeWidth: 4.0,
                                          backgroundColor: ColorsManager.white,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            ColorsManager.red
                                                .withAlpha((0.8 * 255).toInt()),
                                          ),
                                        ),
                                      ),
                                      if (!_isRecordingVideo)
                                        Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorsManager.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!_isRecordingVideo)
                                IconButton(
                                  icon: const Icon(Icons.sync,
                                      color: ColorsManager.white),
                                  onPressed: _switchCamera,
                                ),
                              if (_isRecordingVideo)
                                const SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.send,
                                  color: ColorsManager.white),
                              onPressed: () {
                                _uploadVideo();
                                // Close screen only if upload is successful
                                // The actual navigation will now be handled in the BlocListener
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Close Button (Top Left)
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: ColorsManager.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // Zoom Level Indicator
                  Positioned(
                    top: 80.0,
                    right: 16.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child:
                    CircularProgressIndicator()), // Loading indicator while initializing
      ),
    );
  }
}
