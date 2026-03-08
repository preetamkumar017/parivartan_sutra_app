import 'package:flutter_test/flutter_test.dart';
import 'package:parivartan_sutra/app/routes/app_routes.dart';
import 'package:parivartan_sutra/app/app.dart';
import 'package:parivartan_sutra/core/config/env_config.dart';
import 'package:parivartan_sutra/core/services/shared_prefs_service.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    EnvConfig.initialize(Environment.dev);
    await SharedPrefsService.instance.init();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App(initialRoute: AppRoutes.login));
    expect(find.byType(App), findsOneWidget);
  });
}
