import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../networking/dio_factory.dart';
import '../theming/colors.dart';

/// A banner widget that shows when data is being displayed from cache
class CachedDataBanner extends StatelessWidget {
  /// The response to check if it's from cache
  final Response? response;

  /// Optional custom text to display
  final String? customText;

  /// Whether to show a refresh button
  final bool showRefreshButton;

  /// Callback when refresh button is pressed
  final VoidCallback? onRefresh;

  const CachedDataBanner({
    super.key,
    required this.response,
    this.customText,
    this.showRefreshButton = true,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    // Only show the banner if the response is from cache
    if (!CacheUtils.isResponseFromCache(response)) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      color: ColorsManager.mainRose.withAlpha((0.1 * 255) as int),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.cloud_off,
            size: 16,
            color: ColorsManager.mainRose,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              customText ??
                  'You\'re viewing cached data due to connection issues',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorsManager.mainRose,
                  ),
            ),
          ),
          if (showRefreshButton && onRefresh != null)
            TextButton(
              onPressed: onRefresh,
              child: const Text(
                'Refresh',
                style: TextStyle(
                  color: ColorsManager.mainRose,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
