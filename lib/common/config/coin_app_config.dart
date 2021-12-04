import 'app_config.dart';

class CoinAppConfig extends AppConfig {
  CoinAppConfig({
    required String apiKey,
    required String baseUrlCoinCap,
  }) : super(
          apiKey: apiKey,
          baseUrlCoinCap: baseUrlCoinCap,
        );
}
