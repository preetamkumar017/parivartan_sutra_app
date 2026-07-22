import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/session/session_manager.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_loader.dart';
import '../../base/base_view.dart';
import '../controllers/home_controller.dart';
import '../models/child_model.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('app_name'.tr),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: controller.logout,
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    if (!controller.isParent) {
      return _buildNonParentPlaceholder(context);
    }

    return Obx(() {
      if (controller.isPageLoading) {
        return const AppLoader(fullScreen: false);
      }

      return RefreshIndicator(
        onRefresh: controller.refresh,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: controller.children.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyState(context))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildChildCard(
                          context,
                          controller.children[index],
                        ),
                        childCount: controller.children.length,
                      ),
                    ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
    final mobile = SessionManager.instance.getUserMobile();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mobile != null ? 'Welcome, $mobile' : 'welcome'.tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your Children',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(BuildContext context, ChildModel child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
          child: Text(
            child.name.isNotEmpty ? child.name[0].toUpperCase() : '?',
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
          ),
        ),
        title: Text(
          child.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          'Class ${child.className}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Icon(
          child.hasLogin ? Icons.verified_user_outlined : Icons.person_add_alt_outlined,
          color: child.hasLogin ? AppColors.success : AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.family_restroom_outlined,
            size: 64,
            color: AppColors.textHintLight,
          ),
          const SizedBox(height: 16),
          Text(
            'No children added yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'retry'.tr,
            onPressed: controller.fetchChildren,
            type: AppButtonType.outlined,
            width: 160,
            height: 44,
          ),
        ],
      ),
    );
  }

  Widget _buildNonParentPlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction_outlined,
              size: 64,
              color: AppColors.textHintLight,
            ),
            const SizedBox(height: 16),
            Text(
              'Student dashboard not built yet.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
