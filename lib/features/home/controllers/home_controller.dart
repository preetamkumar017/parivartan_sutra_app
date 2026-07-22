import 'package:get/get.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/services/api_service.dart';
import '../../../core/session/session_manager.dart';
import '../../../core/utils/app_logger.dart';
import '../../base/base_controller.dart';
import '../models/child_model.dart';

/// First real feature screen: a parent's list of children, from the
/// actual backend (`GET parent/children`) rather than the old generic
/// `/dashboard` template list.
class HomeController extends BaseController {
  final RxList<ChildModel> children = <ChildModel>[].obs;

  final _apiService = _ParentApiService();

  bool get isParent => SessionManager.instance.isParent();

  @override
  void onInit() {
    super.onInit();
    if (isParent) {
      fetchChildren();
    }
  }

  Future<void> fetchChildren() async {
    await runWithLoading(
      () async {
        final response = await _apiService.getChildren();
        if (response.success && response.data != null) {
          children.assignAll(response.data!);
          AppLogger.success(
            'HomeController',
            'Loaded ${children.length} children',
          );
        }
      },
      pageLoading: true,
      showError: true,
    );
  }

  @override
  Future<void> refresh() async {
    await runWithRefresh(() async {
      final response = await _apiService.getChildren();
      if (response.success && response.data != null) {
        children.assignAll(response.data!);
      }
    });
  }

  Future<void> logout() async {
    await SessionManager.instance.logout();
  }
}

class _ParentApiService extends ApiService {
  Future<dynamic> getChildren() async {
    return await get(
      ApiEndpoints.parentChildren,
      fromJson: (data) {
        if (data is List) {
          return data
              .map((e) => ChildModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <ChildModel>[];
      },
    );
  }
}
