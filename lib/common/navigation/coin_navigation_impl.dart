import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:provider/provider.dart';
import 'package:sf_flutter_coding_challenge/common/navigation/coin_navigation.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_viewmodel.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_widget.dart';

import 'coin_route.dart';

class CoinNavigationImpl extends CoinNavigation<CoinRoute> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  String get initialRoute => CoinRoute.home.routeName!;

  @override
  BuildContext get navigationContext => navigatorKey.currentState!.context;

  @override
  Route? onGenerateRoute(RouteSettings settings) {
    return _buildRoutes(settings);
  }

  @override
  void pop<R>({R? result}) {
    Navigator.pop(navigationContext, result);
  }

  @override
  void popUntil(CoinRoute route) {
    Navigator.popUntil(
      navigationContext,
      (curr) => curr.settings.name == route.routeName,
    );
  }

  @override
  Future<R> pushNamed<R>(CoinRoute to,
      {Map<String, dynamic>? arguments}) async {
    assert(
      to.routeName != null,
      "Route name must not be null! If you see this exception, go to the"
      "coin_route file and add the route on the extension.",
    );

    final result = await Navigator.pushNamed(
      navigationContext,
      to.routeName!,
      arguments: arguments,
    );

    return result as R;
  }

  Route? _buildRoutes(RouteSettings settings) {
    final route = settings.name!.route;

    switch (route) {
      case CoinRoute.home:
        return _buildRoute(
          ChangeNotifierProvider(
            builder: (_, __) => const HomePageWidget(),
            create: (ctx) => HomePageViewModel(),
          ),
          settings,
        );
      default:
        return null;
    }
  }

  Route _buildRoute(Widget child, RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => child,
    );
  }
}
