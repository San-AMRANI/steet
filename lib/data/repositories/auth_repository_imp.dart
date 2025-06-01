import 'package:steet/data/data_sources/auth_data_source.dart';
import 'package:steet/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImp({required this.dataSource});

  @override
  Future<(bool, String?)> signIn(
      String usernameOrEmail, String password) async {
    // returns a tuple of (isAuthenticated, userId)
    try {
      return await dataSource.signIn(usernameOrEmail, password);
    } catch (e) {
      // Handle or log the error as needed
      return (false, null);
    }
  }

  @override
  Future<(bool, String?)> signUp(Map<String, dynamic> userData) async {
    try {
      print(
          "Repooository : Starting sign up with userData: ${userData.toString()}");
      return await dataSource.signUp(userData);
    } catch (e) {
      // Handle or log the error as needed
      return (false, null);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await dataSource.logout();
    } catch (e) {
      // Handle or log the error as needed
      // Optionally rethrow or swallow
    }
  }

  @override
  Future<(bool, String?)> isAuthenticated() async {
    try {
      return await dataSource.isAuthenticated();
    } catch (e) {
      // Handle or log the error as needed
      return (false, null);
    }
  }

  @override
  Future<(bool, String?)> changePassword(
      String username,
      String currentPassword,
      String newPassword,
      String confirmPassword) async {
    try {
      return await dataSource.changePassword(
          username, currentPassword, newPassword, confirmPassword);
    } catch (e) {
      // Handle or log the error as needed
      return (false, null);
    }
  }
}
