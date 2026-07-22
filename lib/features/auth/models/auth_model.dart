/// Matches the real response of `POST login`
/// (`App\Modules\Api\Controllers\AuthController::login()`):
/// ```
/// { token, token_type, expires_at,
///   user: { id, role, profile_id, name, mobile, email } }
/// ```
/// No `refresh_token` — the backend doesn't implement a refresh flow;
/// tokens are just long-lived (30 days) and re-issued via another `login`.
class AuthUserModel {
  final int id;
  final String role;
  final int? profileId;
  final String? name;
  final String mobile;
  final String? email;
  final String token;
  final String tokenType;
  final String expiresAt;

  const AuthUserModel({
    required this.id,
    required this.role,
    this.profileId,
    this.name,
    required this.mobile,
    this.email,
    required this.token,
    required this.tokenType,
    required this.expiresAt,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? const {};
    return AuthUserModel(
      id: user['id'] as int? ?? 0,
      role: user['role'] as String? ?? '',
      profileId: user['profile_id'] as int?,
      name: user['name'] as String?,
      mobile: user['mobile'] as String? ?? '',
      email: user['email'] as String?,
      token: json['token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresAt: json['expires_at'] as String? ?? '',
    );
  }

  bool get isParent => role == 'parent';
  bool get isStudent => role == 'student';
}
