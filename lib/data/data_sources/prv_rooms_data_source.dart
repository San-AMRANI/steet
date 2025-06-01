import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
        'visible': isVisible,
        'createdBy': createdBy,
      };

      // Create form data with room JSON and image file
      final formData = FormData.fromMap({
        'prvRoom': MultipartFile.fromString(
          jsonEncode(roomData),
          contentType: MediaType.parse('application/json'),
        ),
        'imageFile': MultipartFile.fromBytes(
          imageBytes,
          filename: 'room_image.jpg',
          contentType: MediaType.parse('image/jpeg'),
        ),
      });

      print('Creating private room with data: $roomData'); // Debug log

      final response = await _dioService.post(
        ApiEndpoints.createStudentPrivateRoom,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response is Map<String, dynamic>) {
        if (response.containsKey('data')) {
          return PrvRoomModel.fromJson(response['data']);
        }
        return PrvRoomModel.fromJson(response);
      }

      throw Exception('Unexpected response format');
    } catch (e, stackTrace) {
      print('Error creating private room: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to create private room: $e');
    }
  }

  // Add new method for sending invitations
  Future<bool> sendInvitation({
    required String roomId,
    required String invitedStudentId,
    required String inviterId,
  }) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.sendInvitation,
        queryParameters: {
          'roomId': roomId,
          'invitedStudentId': invitedStudentId,
          'inviterId': inviterId,
        },
      );

      // Handle boolean response
      if (response is bool) {
        return response;
      }
      
      // If response is a Map, try to get boolean value
      if (response is Map<String, dynamic>) {
        return response['data'] ?? false;
      }

      return false;
    } catch (e) {
      print('Error sending invitation: $e');
      throw Exception('Failed to send invitation: $e');
    }
  }
}
