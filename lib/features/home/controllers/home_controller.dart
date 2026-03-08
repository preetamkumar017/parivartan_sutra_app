import 'package:get/get.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../base/base_controller.dart';
import '../models/home_model.dart';

class HomeController extends BaseController {
  // ─── State ───────────────────────────────────────────────────────────────────
  final RxList<HomeModel> items = <HomeModel>[].obs;
  final RxString welcomeMessage = ''.obs;

  // ─── Service ─────────────────────────────────────────────────────────────────
  final _apiService = _HomeApiService();

  // ─── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  // ─── Actions ─────────────────────────────────────────────────────────────────

  Future<void> fetchDashboard() async {
    await runWithLoading(
      () async {
        final response = await _apiService.getDashboard();
        if (response.success && response.data != null) {
          items.assignAll(response.data!);
          welcomeMessage.value = 'welcome_back'.tr;
          AppLogger.success('HomeController', 'Dashboard loaded: ${items.length} items');
        }
      },
      pageLoading: true,
      showError: true,
    );
  }

  @override
  Future<void> refresh() async {
    await runWithRefresh(() async {
      final response = await _apiService.getDashboard();
      if (response.success && response.data != null) {
        items.assignAll(response.data!);
      }
    });
  }

  void onItemTap(HomeModel item) {
    AppLogger.info('HomeController', 'Item tapped: ${item.id}');
    // Navigate to detail
    // Get.toNamed(AppRoutes.detail, arguments: item);
  }
}

// ─── Home API Service ────────────────────────────────────────────────────────

class _HomeApiService extends ApiService {
  Future<dynamic> getDashboard() async {
    return await get(
      ApiEndpoints.dashboard,
      fromJson: (data) {
        if (data is List) {
          return data
              .map((e) => HomeModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <HomeModel>[];
      },
    );
  }
}
