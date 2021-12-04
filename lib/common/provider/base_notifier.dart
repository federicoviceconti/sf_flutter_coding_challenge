import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sf_flutter_coding_challenge/common/config/app_config.dart';
import 'package:sf_flutter_coding_challenge/common/navigation/coin_navigation.dart';

abstract class BaseNotifier extends ChangeNotifier {
  CoinNavigation get navigation => getInstance<CoinNavigation>();

  AppConfig get appConfig => getInstance<AppConfig>();

  T getInstance<T>() {
    return Provider.of<T>(
      navigation.navigationContext,
      listen: false,
    );
  }
}