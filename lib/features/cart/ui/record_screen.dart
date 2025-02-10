import 'dart:developer';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
import 'dart:async';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

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
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        log('No available cameras.');
        return;
      }

      // Select the first rear camera
      final camera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => cameras.first);

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high, // Use the highest available resolution
        enableAudio: true, // Enable audio recording
      );

      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture;

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
      // final Directory appDocumentDir = await getApplicationDocumentsDirectory();
      // final String videoPath =
      //     path.join(appDocumentDir.path, '${DateTime.now()}.mp4');
      // await _cameraController!.startVideoRecording();

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
      });
      _timer?.cancel();

      // Handle the video file (e.g., save it, display it)
      log('Video recorded to ${videoFile.path}');
      //TODO: Add logic to handle the recorded video (e.g., display, upload)
    } catch (e) {
      log('Error stopping video recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                // Camera Preview covering the whole screen
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Scale the camera preview to cover the entire screen.
                        return Transform.scale(
                          scale: _cameraController!.value.aspectRatio >
                                  size.aspectRatio
                              ? _cameraController!.value.aspectRatio /
                                  size.aspectRatio
                              : size.aspectRatio /
                                  _cameraController!.value.aspectRatio,
                          child: Center(
                            child: CameraPreview(_cameraController!),
                          ),
                        );
                      } else {
                        // Otherwise, display a loading indicator.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
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
                              icon: const Icon(Icons.flash_on,
                                  color: Colors.white),
                              onPressed: () {
                                //TODO: Add logic for flash control
                              },
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
                                        backgroundColor: Colors.white,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.pinkAccent),
                                      ),
                                    ),
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.sync, color: Colors.white),
                              onPressed: () {
                                //TODO: Add logic to switch camera
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
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
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Loading indicator while initializing
    );
  }
}
