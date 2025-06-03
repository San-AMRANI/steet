

abstract class AuthRepository {

  Future<(bool,bool, String?)> signIn(String usernameOrEmail, String password);

  Future<(bool, String?)> signUp(Map<String, dynamic> userData);

  Future<void> signOut();

  Future<(bool, String?)> isAuthenticated();

  Future<(bool, String?)> changePassword(
      String username,
      String currentPassword,
      String newPassword,
      String confirmPassword);

}