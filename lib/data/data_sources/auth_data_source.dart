import 'dart:convert';
import 'package:steet/core/utils/secure_storage_service.dart';
import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';

class AuthDataSource {
  late final DioService _dioService;
  late final SecureStorageService _storageService;
  // Fallback storage for platforms without secure storage support

  AuthDataSource() {
    print("AuthDataSource: Constructor called");
    try {
      _dioService = DioService();
      _storageService = SecureStorageService();
      // Initialize the storage service
      _storageService.initialize();
      print("AuthDataSource: Services successfully created");
    } catch (e) {
      print("AuthDataSource: Error during initialization: $e");
      rethrow;
    }
  }

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';

  Future<(bool, String?)> signIn(
      String usernameOrEmail, String password) async {
    print(
        "AuthDataSource: signIn method called with usernameOrEmail: $usernameOrEmail");

    try {
      // Use queryParameters instead of data since backend expects @RequestParam
      final response = await _dioService.post(
        ApiEndpoints.login,
        data: {'usernameOrEmail': usernameOrEmail, 'password': password},
      );

      print("AuthDataSource: Received login response: ${response.toString()}");

      // Check if we have an access token in the response
      if (response != null && response['accessToken'] != null) {
        // Store token and userId in secure storage
        await _storageService.write(_tokenKey, response['accessToken']);
        await _storageService.write(_userIdKey, response['userId'].toString());

        return (true, response['userId'].toString());
      }

      return (false, null);
    } catch (e) {
      print("AuthDataSource: Exception in signIn: $e");
      return (false, "Login failed: ${e.toString()}");
    }
  }

  Future<(bool, String?)> signUp(Map<String, dynamic> userData) async {
    print(
        "AuthDataSource: signUp method called with data: ${JsonEncoder().convert(userData)}");

    try {
      final response = await _dioService.post(ApiEndpoints.studentRegister,
          data: JsonEncoder().convert(userData));
      print(
          "AuthDataSource: Received response from API ${response.toString()}");

      if (response.toString().contains('message')) {
        return (true, response['message'] as String?);
      }

      return (false, response['details'] as String?);
    } catch (e) {
      print("AuthDataSource: Exception in signUp: $e");
      rethrow; // Make sure to rethrow so the repository can handle it
    }
  }

  Future<void> logout() async {
    // Remove the token from secure storage
    await _storageService.clearAll();
  }

  Future<(bool, String?)> isAuthenticated() async {
    // Check if the user is authenticated
    final token = await _storageService.read(_tokenKey);
    final userId = await _storageService.read(_userIdKey);
    return (token != null, userId);
  }

  Future<(bool, String?)> changePassword(
      String username,
      String currentPassword,
      String newPassword,
      String confirmPassword) async {
    try {
      final response = await _dioService.put(
        ApiEndpoints.changePassword.replaceFirst('{username}', username),
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword
        },
      );

      if (response['message'] == true) {
        return (true, response['message'] as String?);
      }

      return (false, response['details'] as String?);
    } catch (e) {
      print("AuthDataSource: Exception in changePassword: $e");
      rethrow;
    }
  }
}
