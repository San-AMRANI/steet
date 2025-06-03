import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/auth_data_source.dart';
import 'package:steet/data/repositories/auth_repository_imp.dart';
import 'package:steet/domain/repositories/auth_repository.dart';
import 'package:steet/presentation/providers/states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  late final AuthRepository _authRepository;

  AuthNotifier() : super(AuthState()) {
    _authRepository = AuthRepositoryImp(dataSource: AuthDataSource());
  }

  Future<void> signIn(String usernameOrEmail, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final (isAuthenticated,isAdmin, userId) =
          await _authRepository.signIn(usernameOrEmail, password);

      if (isAuthenticated) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userId: userId,
          isAdmin: isAdmin,
        );
      } else {
        state = state.copyWith(error: 'Invalid credentials', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> signUp(Map<String, dynamic> userData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      print("Starting sign up with userData: ${userData.toString()}");
      final (isSuccess, message) = await _authRepository.signUp(userData);
      print("Sign up result: isSuccess=$isSuccess, message=$message");

      if (isSuccess) {
        state = state.copyWith(isLoading: false, isRegistred: true, success: message);
      } else {
        state = state.copyWith(error: message, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> checkAuthStatus() async {
    print("Starting auth check, setting loading to true");
    state = state.copyWith(isLoading: true);
    try {
      final (isAuthenticated, isAdmin , userId ) = await _authRepository.isAuthenticated();
      print(
          "Auth check complete: authenticated=$isAuthenticated, setting loading to false");
      state = state.copyWith(
        isAuthenticated: isAuthenticated,
        userId: userId,
        isAdmin: isAdmin,
        isLoading: false,
      );
    } catch (e) {
      print("Auth check error: $e, setting loading to false");
      state = state.copyWith(
        isAuthenticated: false,
        isAdmin: false,
        userId: null,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authRepository.signOut();
      state = state.copyWith(isAuthenticated: false, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<bool> changePassword(
      String username, String currentPassword, String newPassword, String confirmPassword) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final (isSuccess, message) = await _authRepository.changePassword(
          username, currentPassword, newPassword, confirmPassword);

      if (isSuccess) {
        state = state.copyWith(success: message, isLoading: false);
        return true; // Indicate success
      } else {
        state = state.copyWith(error: message, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
    return state.success != null;
  }

  void resetResponseStatus() {
    // Clear any error messages and reset loading state
    state = state.copyWith(
      error: null,
      isLoading: false,
      isRegistred: false,
      success: null,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
