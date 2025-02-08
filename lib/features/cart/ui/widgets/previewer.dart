import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlparser;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/theming/colors.dart';

class LinkPreviewGenerator extends StatefulWidget {
  final String url;

  const LinkPreviewGenerator({super.key, required this.url});

  @override
  State<LinkPreviewGenerator> createState() => _LinkPreviewGeneratorState();
}

class _LinkPreviewGeneratorState extends State<LinkPreviewGenerator> {
  String? _imageUrl;
  String? _title;
  String? _description;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchPreviewData();
  }

  Future<void> _fetchPreviewData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _imageUrl = null;
      _title = null;
      _description = null;
    });

    try {
      if (widget.url.contains("youtube.com") ||
          widget.url.contains("youtu.be")) {
        // Handle YouTube URL
        _extractYouTubeData(widget.url);
      } else if (widget.url.contains("vimeo.com")) {
        // Handle Vimeo URL
        _extractVimeoData(widget.url);
      } else if (widget.url.endsWith(".jpg") ||
          widget.url.endsWith(".jpeg") ||
          widget.url.endsWith(".png") ||
          widget.url.endsWith(".gif")) {
        // Handle direct image URL
        setState(() {
          _imageUrl = widget.url;
          _isLoading = false;
        });
      } else {
        // Generic URL handling (web scraping)
        await _scrapeWebpage(widget.url);
      }
    } catch (e) {
      print("Error fetching preview data: $e");
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  // Extract YouTube data
  Future<void> _extractYouTubeData(String url) async {
    // Example: Extract video ID from URL and construct thumbnail URL
    String? videoId;

    if (url.contains("youtube.com")) {
      videoId = Uri.parse(url).queryParameters['v'];
    } else if (url.contains("youtu.be")) {
      videoId = url.split('/').last;
    }

    if (videoId != null) {
      setState(() {
        _imageUrl = "https://img.youtube.com/vi/$videoId/0.jpg";
        _title =
            "YouTube Video"; // You can fetch the title by scraping or using the YouTube API
        _description = "YouTube Video Description"; // Fetch from API or scrape
        _isLoading = false;
      });
    } else {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  // Extract Vimeo Data
  Future<void> _extractVimeoData(String url) async {
    try {
      final response = await http
          .get(Uri.parse("https://vimeo.com/api/oembed.json?url=$url"));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          _imageUrl = jsonResponse['thumbnail_url'];
          _title = jsonResponse['title'];
          _description = jsonResponse['description'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _scrapeWebpage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = htmlparser.parse(response.body);

        setState(() {
          _title = document.head
                  ?.querySelector('meta[property="og:title"]')
                  ?.attributes['content'] ??
              document.head?.querySelector('title')?.text ??
              '';
          _description = document.head
                  ?.querySelector('meta[property="og:description"]')
                  ?.attributes['content'] ??
              document.head
                  ?.querySelector('meta[name="description"]')
                  ?.attributes['content'] ??
              '';
          _imageUrl = document.head
                  ?.querySelector('meta[property="og:image"]')
                  ?.attributes['content'] ??
              '';

          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(widget.url))) {
          await launchUrl(Uri.parse(widget.url),
              mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch ${widget.url}';
        }
      },
      child: _isLoading
          ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            )
          : _hasError
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svgs/small_logo.svg',
                      colorFilter: const ColorFilter.mode(
                        ColorsManager.lightGrey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              : _imageUrl != null && _imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: _imageUrl!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200, // Adjust as needed
                    )
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: Text("No preview available.")),
                    ),
    );
  }
}
