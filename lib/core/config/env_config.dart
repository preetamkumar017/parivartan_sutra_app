enum Environment { dev, prod }

class EnvConfig {
  static late EnvConfig _instance;
  static EnvConfig get instance => _instance;

  final Environment environment;
  final String baseUrl;
  final String appName;
  final bool enableLogging;

  EnvConfig._({
    required this.environment,
    required this.baseUrl,
    required this.appName,
    required this.enableLogging,
  });

  static void initialize(Environment env) {
    switch (env) {
      case Environment.dev:
        _instance = EnvConfig._(
          environment: Environment.dev,
          // Real backend: same host, plain `api/` prefix, no version segment
          // (see app/Config/Routes.php's `api` group + app.baseURL in
          // ../parivartan-sutra-new/app/Config/App.php, default `php spark serve`
          // port 8080). Android emulator can't reach `localhost` directly —
          // use `10.0.2.2` instead of `127.0.0.1` when running on an emulator.
          baseUrl: 'http://127.0.0.1:8080/api/',
          appName: 'Parivartan Sutra [DEV]',
          enableLogging: true,
        );
        break;
      case Environment.prod:
        _instance = EnvConfig._(
          environment: Environment.prod,
          // Not deployed anywhere yet — no real prod domain exists to confirm.
          // Replace once the backend has an actual production host.
          baseUrl: 'https://api.parivartansutra.com/api/',
          appName: 'Parivartan Sutra',
          enableLogging: false,
        );
        break;
    }
  }

  bool get isDev => environment == Environment.dev;
  bool get isProd => environment == Environment.prod;
}
