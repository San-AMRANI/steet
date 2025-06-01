import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";
import "package:steet/core/utils/secure_storage_service.dart";

class AuthNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final Widget placeholder;
  final Widget errorWidget;
  final double width;
  final double height;
  final BoxFit fit;
  final SecureStorageService _storageService = SecureStorageService();

  AuthNetworkImage({
    super.key,
    required this.imageUrl,
    required this.placeholder,
    required this.errorWidget,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return errorWidget;
    }

    // Add timestamp to force image refresh
    final String uniqueUrl = "$imageUrl?t=${DateTime.now().millisecondsSinceEpoch}";
    
    return FutureBuilder<String?>(
      future: _storageService.read('auth_token'),
      builder: (context, snapshot) {
        // Auth headers for the image request
        Map<String, String> authHeaders = {};
        
        // Add authentication token if available
        if (snapshot.hasData && snapshot.data != null) {
          authHeaders['Authorization'] = 'Bearer ${snapshot.data}';
        }

        return CachedNetworkImage(
          imageUrl: uniqueUrl,
          httpHeaders: authHeaders,
          placeholder: (context, url) => placeholder,
          errorWidget: (context, url, error) {
            print("Image loading error: $error for URL: $url");
            return errorWidget;
          },
          width: width,
          height: height,
          fit: fit,
          // Generate a unique cache key to prevent caching issues
          cacheKey: "$uniqueUrl-${DateTime.now().millisecondsSinceEpoch}",
        );
      },
    );
  }
}