
class AuthState{
  final bool isAuthenticated;
  final String? userId;
  final String? success;
  final bool isRegistred;
  final bool isLoading;
  final String? error;

  AuthState({
    this.isAuthenticated = false,
    this.userId,
    this.isLoading = false,
    this.error,
    this.success,
    this.isRegistred = false,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    bool? isLoading,
    String? error,
    String? success,
    bool? isRegistred,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      isRegistred: isRegistred ?? this.isRegistred,
    );
  }
}