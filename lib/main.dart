import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sf_flutter_coding_challenge/common/config/app_config.dart';
import 'package:sf_flutter_coding_challenge/common/http/client/coincap_client.dart';

import 'common/config/coin_app_config.dart';
import 'common/navigation/coin_navigation.dart';
import 'common/navigation/coin_navigation_impl.dart';
import 'common/theme/app_theme.dart';

void main() {
  runApp(const CoinApp());
}

class CoinApp extends StatelessWidget {
  /// Your main Application
  const CoinApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _initProviders(),
      builder: (context, _) => _buildApp(context),
    );
  }

  Widget _buildApp(BuildContext context) {
    final navigation = Provider.of<CoinNavigation>(context);

    return MaterialApp(
      title: 'CoinApp',
      themeMode: AppTheme.themeMode,
      theme: AppTheme.theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
      ],
      navigatorKey: CoinNavigationImpl.navigatorKey,
      onGenerateRoute: navigation.onGenerateRoute,
      initialRoute: navigation.initialRoute,
    );
  }

  List<SingleChildWidget> _initProviders() {
    final apiKey = String.fromEnvironment("API_KEY");
    final baseUrlCoinCap = String.fromEnvironment("COIN_CAP_BASE_URL");

    return [
      Provider<CoinNavigation>(
        create: (ctx) => CoinNavigationImpl(),
      ),
      Provider<AppConfig>(
        create: (ctx) => CoinAppConfig(
          apiKey: apiKey,
          baseUrlCoinCap: baseUrlCoinCap,
        ),
      ),
      ProxyProvider<AppConfig, CoinCapClient>(
        update: (_, AppConfig appConfig, __) {
          return CoinCapClient(appConfig);
        },
      ),
    ];
  }
}
