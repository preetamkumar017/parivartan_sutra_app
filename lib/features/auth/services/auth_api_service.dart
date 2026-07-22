import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/services/api_service.dart';
import '../models/auth_model.dart';

class AuthApiService extends ApiService {
  /// Single role-detecting login for both parent and student accounts —
  /// the backend looks up `mobile` across both roles itself, there's no
  /// separate parent/student endpoint.
  Future<ApiResponse<AuthUserModel>> login(
    String mobile,
    String password, {
    String? device,
  }) {
    return post<AuthUserModel>(
      ApiEndpoints.login,
      body: {
        'mobile': mobile,
        'password': password,
        if (device != null) 'device': device,
      },
      fromJson: (data) => AuthUserModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Revokes only the token used on this request.
  Future<ApiResponse<dynamic>> logout() {
    return post<dynamic>(ApiEndpoints.logout);
  }
}
