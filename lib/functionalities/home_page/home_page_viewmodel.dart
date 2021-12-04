import 'dart:async';

import 'package:intl/intl.dart';
import 'package:sf_flutter_coding_challenge/common/mixin/loader_mixin.dart';
import 'package:sf_flutter_coding_challenge/common/provider/base_notifier.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_datamanager.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/expandable_asset_model.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/user_wallet_information.dart';

class HomePageViewModel extends BaseNotifier with LoaderMixin {
  final HomePageDataManager dataManager;

  double? _initialAmount;

  String get investedCapitalFormatted {
    return NumberFormat.simpleCurrency(
      locale: 'en_US',
      decimalDigits: 2,
    ).format(_getInvestedCapital());
  }

  double _getInvestedCapital() {
    return _userWalletInformation?.cryptos
        .map((e) => e.initialUsdDollar * e.amount)
        .reduce((value, element) => value + element) ?? 0.0;
  }

  //TODO
  String get profitAmountFormatted => '';

  String get currentAmountFormatted {
    return NumberFormat.simpleCurrency(
      locale: 'en_US',
      decimalDigits: 2,
    ).format(_getCurrentAmount());
  }

  double _getCurrentAmount() {
    return _assets
        .map((e) => e.value ?? 0.0)
        .reduce((amountOne, amountTwo) => amountOne + amountTwo);
  }

  String get liquidityFormatted =>
      NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(
        _getCurrentAmount() - _getInvestedCapital(),
      );

  double? get initialAmount => _initialAmount;

  double? _currentAmount;

  double? get currentAmount => _currentAmount;

  UserWalletInformation? _userWalletInformation;

  List<ExpandableAssetModel> _assets = [];

  List<ExpandableAssetModel> get assets => _assets;

  HomePageViewModel({
    required this.dataManager,
  });

  void init() async {
    showProgress();
    _userWalletInformation = await dataManager.getUserInfo();
    _initialAmount = _userWalletInformation?.cryptos
            .map((e) => e.initialUsdDollar)
            .reduce((value, element) => value + element) ??
        0.0;

    _initAssetTimer();
  }

  void onAssetItemTap(int index) {
    _assets[index].isExpanded = !_assets[index].isExpanded;
    notifyListeners();
  }

  void _initAssetTimer() {
    showProgress();

    _getAssets();
    Timer.periodic(Duration(seconds: 10), (timer) async {
      _getAssets();
    });
  }

  void _getAssets() async {
    final coins = _userWalletInformation?.cryptos.map((e) => e.crypto).toList();
    final assets = await dataManager.getAssets(
      coins: coins,
      wallet: _userWalletInformation,
    );

    if (assets.isNotEmpty) {
      _assets = assets;
      hideProgress();
    }
  }
}
