import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/services/api_service.dart';
import '../models/auth_model.dart';

class AuthApiService extends ApiService {
  // Parent: send OTP to email
  Future<ApiResponse<Map<String, dynamic>>> sendOtp(String email) {
    return post<Map<String, dynamic>>(
      ApiEndpoints.sendOtp,
      body: {'email': email},
      fromJson: (data) => Map<String, dynamic>.from(data as Map),
    );
  }

  // Parent: verify OTP and get tokens
  Future<ApiResponse<AuthUserModel>> verifyOtp(String email, String otp) {
    return post<AuthUserModel>(
      ApiEndpoints.verifyOtp,
      body: {'email': email, 'otp': otp},
      fromJson: (data) =>
          AuthUserModel.fromJson(data as Map<String, dynamic>),
    );
  }

  // Student: email + password login
  Future<ApiResponse<AuthUserModel>> studentLogin(
      String email, String password) {
    return post<AuthUserModel>(
      ApiEndpoints.studentLogin,
      body: {'email': email, 'password': password},
      fromJson: (data) =>
          AuthUserModel.fromJson(data as Map<String, dynamic>),
    );
  }

  // Refresh access token
  Future<ApiResponse<AuthUserModel>> refreshToken(String refreshToken) {
    return post<AuthUserModel>(
      ApiEndpoints.refreshToken,
      body: {'refresh_token': refreshToken},
      fromJson: (data) =>
          AuthUserModel.fromJson(data as Map<String, dynamic>),
    );
  }

  // Logout
  Future<ApiResponse<Map<String, dynamic>>> logout(String refreshToken) {
    return post<Map<String, dynamic>>(
      ApiEndpoints.logout,
      body: {'refresh_token': refreshToken},
      fromJson: (data) => Map<String, dynamic>.from(data as Map),
    );
  }
}
