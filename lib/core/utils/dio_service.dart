import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:steet/core/utils/secure_storage_service.dart';

class DioService {
  late final Dio _dio;
  final SecureStorageService _storageService = SecureStorageService();

  DioService({String? baseUrl, Map<String, dynamic>? headers}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? dotenv.env['BASE_URL'] ?? '',
      headers: headers ?? {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));

    // Add the auth interceptor
    // _dio.interceptors.add(_createAuthInterceptor());
  }

  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) async {
      print("DioService: Intercepting request to ${options.path}");
      
      // Apply the token if available
      try {
        final token = await _storageService.read('auth_token');
        print("tooooooooooooken$token");
        print("DioService: Retrieved token: $token");
        if (token != null) {
          print("DioService: Adding token to request");
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          print("DioService: No token found for request");
        }
        
      } catch (e) {
        print("DioService: Error reading auth token: $e");
        // Continue without token - don't let this crash the app
      }

      return handler.next(options);
    });
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);

      if (response.statusCode != 200) {
        throw Exception('Server returned status code ${response.statusCode}');
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Server returned status code ${response.statusCode}');
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      if (response.statusCode != 200) {
        throw Exception('Server returned status code ${response.statusCode}');
      }

      if (response.data is! Map<String, dynamic>) {
        throw Exception(
            'Expected JSON object response, got ${response.data.runtimeType}');
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<String> uploadFile({
    required String endpoint,
    required String filePath,
    String fileField = 'file',
    Map<String, dynamic>? additionalFields,
  }) async {
    try {
      final formData = FormData.fromMap({
        fileField: await MultipartFile.fromFile(filePath),
        if (additionalFields != null) ...additionalFields,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }

      if (response.data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      // Assuming the API returns the file URL in a field called 'url'
      final url = response.data['url'] as String?;
      if (url == null) {
        throw Exception('No file URL in response');
      }

      return url;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timed out');
      case DioExceptionType.badResponse:
        return Exception(
            'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.badCertificate:
        return Exception('Invalid certificate');
      case DioExceptionType.connectionError:
        return Exception('Connection error');
      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return Exception('No internet connection');
        }
        return Exception('Unknown error: ${e.error}');
    }
  }
}
