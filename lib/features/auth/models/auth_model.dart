class AuthTokenModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  const AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken:  json['access_token']  as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      tokenType:    json['token_type']    as String? ?? 'Bearer',
      expiresIn:    json['expires_in']    as int?    ?? 3600,
    );
  }
}

class AuthUserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final AuthTokenModel tokens;

  const AuthUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.tokens,
  });

  /// Backend returns flat structure:
  /// { access_token, refresh_token, token_type, expires_in, user: {id,name,email,role} }
  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;
    return AuthUserModel(
      id:     user['id']    as int?    ?? 0,
      name:   user['name']  as String? ?? '',
      email:  user['email'] as String? ?? '',
      role:   user['role']  as String? ?? '',
      tokens: AuthTokenModel.fromJson(json),
    );
  }
}
