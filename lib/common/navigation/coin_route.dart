enum CoinRoute {
  home,
}

extension CoinRouteExt on CoinRoute {
  String? get routeName => {
        CoinRoute.home: '/home',
      }[this];
}

extension CoinRouteString on String {
  CoinRoute? get route => {
        '/home': CoinRoute.home,
      }[this];
}
