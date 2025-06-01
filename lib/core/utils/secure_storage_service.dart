import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  
  factory SecureStorageService() {
    return _instance;
  }
  
  SecureStorageService._internal();
  
  late final FlutterSecureStorage? _secureStorage;
  // Fallback storage for platforms without secure storage support
  final Map<String, String> _memoryStorage = {};
  
  bool get isSecureStorageAvailable => _secureStorage != null;
  
  Future<void> initialize() async {
    try {
      _secureStorage = const FlutterSecureStorage();
      print("SecureStorageService: FlutterSecureStorage successfully created");
    } catch (e) {
      print("SecureStorageService: Could not initialize secure storage, using memory fallback: $e");
      _secureStorage = null;
    }
  }
  
  Future<void> write(String key, String value) async {
    try {
      if (_secureStorage != null) {
        await _secureStorage.write(key: key, value: value);
      } else {
        _memoryStorage[key] = value;
      }
    } catch (e) {
      print("Storage write error: $e");
      _memoryStorage[key] = value; // Fallback to memory
    }
  }
  
  Future<String?> read(String key) async {
    try {
      if (_secureStorage != null) {
        return await _secureStorage.read(key: key);
      } else {
        return _memoryStorage[key];
      }
    } catch (e) {
      print("Storage read error: $e");
      return _memoryStorage[key]; // Fallback to memory
    }
  }
  
  Future<void> delete(String key) async {
    try {
      if (_secureStorage != null) {
        await _secureStorage.delete(key: key);
      } else {
        _memoryStorage.remove(key);
      }
    } catch (e) {
      print("Storage delete error: $e");
      _memoryStorage.remove(key); // Fallback to memory
    }
  }
  
  Future<void> clearAll() async {
    try {
      if (_secureStorage != null) {
        await _secureStorage.deleteAll();
      }
      _memoryStorage.clear();
    } catch (e) {
      print("Storage clear error: $e");
      _memoryStorage.clear(); // Fallback to memory
    }
  }
}