import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_loader.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  // ─── Override in subclass ────────────────────────────────────────────────────

  Widget buildBody(BuildContext context);

  // ─── Optional overrides ──────────────────────────────────────────────────────

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget? buildFloatingActionButton(BuildContext context) => null;

  Widget? buildBottomNavigationBar(BuildContext context) => null;

  Widget? buildDrawer(BuildContext context) => null;

  Color? backgroundColor(BuildContext context) => null;

  bool showLoader() => true;

  bool extendBodyBehindAppBar() => false;

  bool resizeToAvoidBottomInset() => true;

  // ─── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: backgroundColor(context),
            appBar: buildAppBar(context),
            extendBodyBehindAppBar: extendBodyBehindAppBar(),
            resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
            floatingActionButton: buildFloatingActionButton(context),
            bottomNavigationBar: buildBottomNavigationBar(context),
            drawer: buildDrawer(context),
            body: buildBody(context),
          ),
          if (showLoader() && controller.isLoading)
            const AppLoader(),
        ],
      ),
    );
  }
}

// ─── BasePageView (with page loading state) ──────────────────────────────────

abstract class BasePageView<T extends BaseController> extends BaseView<T> {
  const BasePageView({super.key});

  Widget buildPageContent(BuildContext context);

  Widget buildPageLoader(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => onRetry(context),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void onRetry(BuildContext context) {}

  @override
  Widget buildBody(BuildContext context) {
    if (controller.isPageLoading) {
      return buildPageLoader(context);
    }
    if (controller.hasError && !controller.isPageLoading) {
      return buildErrorWidget(context, controller.errorMessage);
    }
    return buildPageContent(context);
  }
}
