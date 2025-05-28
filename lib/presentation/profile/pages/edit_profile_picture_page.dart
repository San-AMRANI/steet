import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/core/utils/gallery_access_utils.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/student_provider.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class EditProfilePicturePage extends ConsumerStatefulWidget {
  final Student? authStudent;
  const EditProfilePicturePage({super.key, this.authStudent});

  @override
  ConsumerState<EditProfilePicturePage> createState() =>
      _EditProfilePicturePageState();
}

class _EditProfilePicturePageState
    extends ConsumerState<EditProfilePicturePage> {
  Uint8List? _imageBytes;
  Uint8List? _croppedBytes;

  @override
  void initState() {
    super.initState();
    _loadGalleryAssets();
  }

  bool _isLoading = false;
  bool _loadingGallery = false;
  final _cropController = CropController();

  // Gallery assets
  List<AssetEntity> _galleryAssets = [];
  int _currentPage = 0;
  final int _pageSize = 24; // Number of images to load per page
  bool _hasMoreToLoad = true;

  Future<void> _loadGalleryAssets() async {
    setState(() => _loadingGallery = true);
    try {
      final result = await loadGalleryAssets(page: 0, pageSize: _pageSize);
      setState(() {
        _galleryAssets = result['assets'];
        _hasMoreToLoad = result['hasMore'];
        _currentPage = 0;
        _loadingGallery = false;
      });
    } catch (e) {
      print('Error loading gallery: $e');
      setState(() => _loadingGallery = false);
      // Optionally show error to user
    }
  }

  Future<void> _loadMoreAssets() async {
    if (!_hasMoreToLoad || _loadingGallery) return;
    setState(() => _loadingGallery = true);
    try {
      final result =
          await loadGalleryAssets(page: _currentPage + 1, pageSize: _pageSize);
      final List<AssetEntity> assets = result['assets'];
      setState(() {
        _currentPage++;
        _galleryAssets.addAll(assets);
        _hasMoreToLoad = result['hasMore'];
        _loadingGallery = false;
      });
    } catch (e) {
      print('Error loading more assets: $e');
      setState(() => _loadingGallery = false);
    }
  }

  Future<void> _selectAssetForCrop(AssetEntity asset) async {
    setState(() => _isLoading = true);

    try {
      final bytes = await asset.originBytes;
      if (bytes != null) {
        setState(() {
          _imageBytes = bytes;
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load image')),
        );
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error loading image bytes: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading image')),
      );
    }
  }

  void _cropImage() {
    if (_imageBytes != null) {
      _cropController.crop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _imageBytes != null
          ? AppBar(
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(CupertinoIcons.xmark),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _imageBytes = null; // Exit crop mode
                      _croppedBytes = null; // Reset cropped image
                    });
                  }),
              title: const Text(
                'Crop Image',
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                IconButton(
                  icon: Icon(CupertinoIcons.checkmark),
                  color: Colors.green,
                  onPressed: _cropImage,
                ),
              ],
            )
          : SubPageAppBar(
              title: 'Edit Picture',
              avatarUrl: widget.authStudent!.profilePictureUrl ?? ''),

      body: Column(
        children: [
          // Top half: Preview of profile picture
          Expanded(
            flex: 1,
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _croppedBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            _croppedBytes!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl:
                                  (widget.authStudent?.profilePictureUrl ?? ''),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person, size: 60),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
            ),
          ),

          // Bottom half: Image cropper or gallery grid
          Expanded(
            flex: 2,
            child: _imageBytes != null
                ? Crop(
                    image: _imageBytes!,
                    controller: _cropController,
                    onCropped: (result) {
                      if (result is CropSuccess) {
                        setState(() {
                          _croppedBytes = result.croppedImage;
                          _imageBytes = null; // Exit crop mode
                        });
                      } else if (result is CropFailure) {
                        print('Error cropping image: ${result.cause}');
                        // Handle error case
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to crop image: ${result.cause}')),
                        );
                      }
                    },
                    aspectRatio: 1,
                    withCircleUi: false,
                    baseColor: Colors.black,
                    maskColor: Colors.black.withOpacity(0.6),
                  )
                : _buildGalleryGrid(),
          ),
        ],
      ),
      // Only show save button when cropped image is available
      bottomNavigationBar: _croppedBytes != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),                child: TextButton(
                  onPressed: () async {
                    try {
                      setState(() => _isLoading = true);
                      final imageUrl = await ref.read(studentNotifierProvider.notifier).uploadProfileImage(
                          widget.authStudent!.id, _croppedBytes!);
                      setState(() => _isLoading = false);
                      
                      if (imageUrl != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile picture updated successfully'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      
                      Navigator.of(context).pop();
                    } catch (e) {
                      setState(() => _isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update profile picture: ${e.toString()}'),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Text(
                      'Save Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildGalleryGrid() {
    if (_loadingGallery && _galleryAssets.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent * 0.9) {
            _loadMoreAssets();
          }
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: _galleryAssets.length + (_hasMoreToLoad ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _galleryAssets.length) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          }

          final asset = _galleryAssets[index];
          return GestureDetector(
            onTap: () => _selectAssetForCrop(asset),
            child: AssetThumbnail(asset: asset),
          );
        },
      ),
    );
  }
}

class AssetThumbnail extends StatefulWidget {
  final AssetEntity asset;

  const AssetThumbnail({super.key, required this.asset});

  @override
  State<AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<AssetThumbnail> {
  Uint8List? _thumbnail;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    setState(() => _loading = true);
    final thumbnail = await widget.asset.thumbnailData;
    if (mounted) {
      setState(() {
        _thumbnail = thumbnail;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _thumbnail == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
            child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )),
      );
    }

    return Image.memory(
      _thumbnail!,
      fit: BoxFit.cover,
    );
  }
}
