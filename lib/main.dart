import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'app/routes/app_routes.dart';
import 'core/config/env_config.dart';
import 'core/services/shared_prefs_service.dart';
import 'core/session/session_manager.dart';
import 'core/utils/app_logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Environment ────────────────────────────────────────────────────────────
  EnvConfig.initialize(Environment.dev);

  // ── System UI ──────────────────────────────────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // ── Services Init ──────────────────────────────────────────────────────────
  await SharedPrefsService.instance.init();

  // ── Session Restore ────────────────────────────────────────────────────────
  final sessionRestored = await SessionManager.instance.restoreSession();
  final initialRoute =
      sessionRestored ? AppRoutes.home : AppRoutes.login;

  AppLogger.info('App',
      '🚀 Parivartan Sutra [${EnvConfig.instance.environment.name.toUpperCase()}]');
  AppLogger.info('App', 'Base URL: ${EnvConfig.instance.baseUrl}');
  AppLogger.info('App', 'Initial route: $initialRoute');

  runApp(App(initialRoute: initialRoute));
}
