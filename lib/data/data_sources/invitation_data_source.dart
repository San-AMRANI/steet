import 'dart:convert';
import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/invitation_model.dart';

class InvitationDataSource {
  final DioService _dioService = DioService();

  Future<List<InvitationModel>> getPendingInvitations(String studentId) async {
    try {
      final response = await _dioService.get(
        ApiEndpoints.pendingInvitations.replaceFirst('{studentId}', studentId)
      );

      // Handle the response based on its type
      List<dynamic> invitationsJson;
      if (response is String) {
        final decoded = json.decode(response);
        invitationsJson = decoded is List ? decoded : [decoded];
      } else if (response is List) {
        invitationsJson = response;
      } else if (response is Map<String, dynamic>) {
        invitationsJson = response['data'] as List<dynamic>;
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }

      return invitationsJson.map((json) {
        // Map the invitation data directly without modifying the structure
        return InvitationModel.fromJson(json);
      }).toList();
    } catch (e, stackTrace) {
      print('Error fetching invitations: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch pending invitations: $e');
    }
  }

  Future<bool> acceptInvitation(InvitationModel invitation) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.acceptInvitation,
        queryParameters: {
          'roomId': invitation.room.id,
          'studentId': invitation.invitedStudentId,
        },
      );
      if (response is String) {
        final decoded = json.decode(response);
        return decoded is bool ? decoded : true;
      }
      return response is bool ? response : true;
    } catch (e) {
      throw Exception('Failed to accept invitation: $e');
    }
  }

  Future<bool> rejectInvitation(InvitationModel invitation) async {
    try {
      final response = await _dioService.post(
        ApiEndpoints.rejectInvitation,
        queryParameters: {
          'roomId': invitation.room.id,
          'studentId': invitation.invitedStudentId,
        },
      );
      if (response is String) {
        final decoded = json.decode(response);
        return decoded is bool ? decoded : true;
      }
      return response is bool ? response : true;
    } catch (e) {
      throw Exception('Failed to reject invitation: $e');
    }
  }
} 