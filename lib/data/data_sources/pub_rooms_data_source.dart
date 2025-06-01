import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/pub_room_model.dart';

class PubRoomsDataSource {
  final DioService _dioService = DioService();

  Future<List<PubRoomModel>> getPubRooms() async {
    final dynamic response = await _dioService.get(ApiEndpoints.rooms);
    final List<dynamic> data = response is Map<String, dynamic>
        ? response['data'] as List<dynamic>
        : response as List<dynamic>;

    return data.map((room) => PubRoomModel.fromJson(room)).toList();
  }

  Future<PubRoomModel> createPubRoom({
    required String name,
    required String description,
    required String createdBy,
    required List<String> participation,
    required String imagePath,
  }) async {
    try {
      // Check if file exists before attempting to upload
      final file = File(imagePath);
      if (!await file.exists()) {
        throw Exception('File does not exist: $imagePath');
      }

      // Read file as bytes
      final Uint8List imageBytes = await file.readAsBytes();

      // Create the room data
      final roomData = {
        'name': name,
        'description': description,
        'imageUrl': '', // Empty string for imageUrl
        'createdAt': DateTime.now().toIso8601String(),
        'createdBy': createdBy,
        'participation': participation,
      };

      // Create form data with room JSON and image bytes
      final formData = FormData.fromMap({
        'room': jsonEncode(roomData),
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: 'room_image.jpg',
          contentType: MediaType.parse('image/jpeg'),
        ),
      });

      print('Creating public room with data: $roomData'); // Debug log

      final response = await _dioService.post(
        ApiEndpoints.createPublicRoom,
        data: formData,
      );

      print('Server response: $response'); // Debug log

      if (response is Map<String, dynamic>) {
        if (response.containsKey('data')) {
          return PubRoomModel.fromJson(response['data']);
        }
        return PubRoomModel.fromJson(response);
      }

      throw Exception('Unexpected response format');
    } catch (e, stackTrace) {
      print('Error creating public room: $e'); // Debug log
      print('Stack trace: $stackTrace'); // Debug log
      throw Exception('Failed to create public room: $e');
    }
  }
}
