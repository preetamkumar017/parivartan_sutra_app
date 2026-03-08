import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/services/shared_prefs_service.dart';
import '../../core/session/session_manager.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core singletons — registered permanently
    Get.put<SecureStorageService>(
      SecureStorageService.instance,
      permanent: true,
    );

    Get.put<SharedPrefsService>(
      SharedPrefsService.instance,
      permanent: true,
    );

    Get.put<ApiClient>(
      ApiClient.instance,
      permanent: true,
    );

    Get.put<SessionManager>(
      SessionManager.instance,
      permanent: true,
    );
  }
}
