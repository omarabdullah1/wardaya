import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../theming/colors.dart';

/// A service to handle product sharing functionality throughout the app
class ShareService {
  static final ShareService _instance = ShareService._internal();

  factory ShareService() => _instance;

  ShareService._internal();

  /// Share a product with the given ID and title
  Future<void> shareProduct(
    BuildContext context, {
    required String productId,
    required String productTitle,
  }) async {
    // Create a share link for the product using the website's URL architecture
    final String productUrl =
        'https://www.wardaya.net/products/product/$productId';

    try {
      // Show a modal bottom sheet with sharing options
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (context) => ShareOptionsSheet(
          productUrl: productUrl,
          productTitle: productTitle,
        ),
      );
    } catch (e) {
      // Log error
      debugPrint('Error showing share options: $e');

      // Fallback to clipboard if modal fails
      if (context.mounted) {
        await _copyToClipboard(context, productUrl);
      }
    }
  }

  /// Helper method to copy product URL to clipboard
  Future<void> _copyToClipboard(BuildContext context, String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));

      // Show snackbar from the top
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorsManager.mintGreen,
            content: const Text('Link copied to clipboard!'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
            ),
            dismissDirection: DismissDirection.up,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error copying to clipboard: $e');
    }
  }
}

/// A bottom sheet that shows various sharing options
class ShareOptionsSheet extends StatelessWidget {
  final String productUrl;
  final String productTitle;

  const ShareOptionsSheet({
    super.key,
    required this.productUrl,
    required this.productTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Share Product',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              productTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _buildShareButton(
              context,
              icon: Icons.share,
              label: 'Share via Apps',
              onTap: () => _shareViaApps(context),
            ),
            const SizedBox(height: 12),
            _buildShareButton(
              context,
              icon: Icons.copy,
              label: 'Copy Link',
              onTap: () => _copyLink(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon),
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareViaApps(BuildContext context) async {
    // Close the bottom sheet
    if (context.mounted) {
      Navigator.pop(context);
    }

    // Share using system share sheet
    await Share.share(
      'Check out this product: $productTitle\n$productUrl',
      subject: 'Check out this product from Wardaya',
    );
  }

  Future<void> _copyLink(BuildContext context) async {
    try {
      // Copy to clipboard
      await Clipboard.setData(ClipboardData(text: productUrl));

      // Close the sheet
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorsManager.mintGreen,
            content: const Text('Link copied to clipboard!'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
            ),
            dismissDirection: DismissDirection.up,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error copying link: $e');
    }
  }
}
