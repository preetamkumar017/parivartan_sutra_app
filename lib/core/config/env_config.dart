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
          baseUrl: 'https://dev-api.parivartansutra.com/api/v1',
          appName: 'Parivartan Sutra [DEV]',
          enableLogging: true,
        );
        break;
      case Environment.prod:
        _instance = EnvConfig._(
          environment: Environment.prod,
          baseUrl: 'https://api.parivartansutra.com/api/v1',
          appName: 'Parivartan Sutra',
          enableLogging: false,
        );
        break;
    }
  }

  bool get isDev => environment == Environment.dev;
  bool get isProd => environment == Environment.prod;
}
