import 'package:photo_manager/photo_manager.dart';

/// Loads a page of gallery images.
/// Returns a tuple: (List<AssetEntity> assets, bool hasMore)
Future<Map<String, dynamic>> loadGalleryAssets({
  required int page,
  required int pageSize,
}) async {
  // Request permission if needed
  final PermissionState permission =
      await PhotoManager.requestPermissionExtend();
  if (!permission.isAuth) {
    throw Exception('Permission denied to access photos');
  }

  final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
    onlyAll: true,
    type: RequestType.image,
  );

  if (albums.isNotEmpty) {
    final recentAlbum = albums.first;
    final List<AssetEntity> assets = await recentAlbum.getAssetListPaged(
      page: page,
      size: pageSize,
    );
    return {
      'assets': assets,
      'hasMore': assets.length >= pageSize,
    };
  } else {
    return {
      'assets': <AssetEntity>[],
      'hasMore': false,
    };
  }
}
