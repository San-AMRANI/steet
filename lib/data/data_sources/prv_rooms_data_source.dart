import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/prv_room_model.dart';

class PrvRoomsDataSource {
  final DioService _dioService;

  PrvRoomsDataSource({DioService? dioService})
      : _dioService = dioService ?? DioService();

  Future<PrvRoomModel> createPrvRoom({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required List<String> memberships,
    required String imagePath,
  }) async {
    try {
      // Check if file exists before attempting to upload
      final file = File(imagePath);
      if (!await file.exists()) {
        throw Exception('File does not exist: $imagePath');
      }

      // Create form data with both image and room data
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
        'name': name,
        'description': description,
        'isVisible': isVisible.toString(),
        'createdBy': createdBy,
        'memberships': jsonEncode(memberships),
      });

      final response = await _dioService.post(
        ApiEndpoints.createPrivateRoom,
        data: formData,
      );

      return PrvRoomModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create private room: $e');
    }
  }
}
