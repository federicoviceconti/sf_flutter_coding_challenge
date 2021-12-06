import 'dart:async';

import 'package:sf_flutter_coding_challenge/common/utils/currency_helper.dart';
import 'package:sf_flutter_coding_challenge/common/mixin/loader_mixin.dart';
import 'package:sf_flutter_coding_challenge/common/provider/base_notifier.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_datamanager.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/expandable_asset_model.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/user_wallet_information.dart';
import 'package:collection/collection.dart';

class HomePageViewModel extends BaseNotifier with LoaderMixin {
  final HomePageDataManager dataManager;

  String get investedCapitalFormatted {
    return CurrencyHelper.formatUsd(_getInvestedCapital());
  }

  double _getInvestedCapital() {
    if (_userWalletInformation?.cryptos == null ||
        _userWalletInformation!.cryptos.isEmpty) {
      return 0.0;
    }

    return _userWalletInformation?.cryptos
            .map((e) => e.initialUsdDollar * e.amount)
            .reduce((value, element) => value + element) ??
        0.0;
  }

  String get profitAmountFormatted {
    final actual = _getActualAmount();
    final initial = _getInitial();

    final percentage =
        CurrencyHelper.getPercentage(initial: initial, current: actual)
            .toStringAsFixed(2);

    return actual <= 0
        ? ''
        : '${CurrencyHelper.formatUsd(actual)} ($percentage)%';
  }

  String get currentAmountFormatted {
    return CurrencyHelper.formatUsd(_getCurrentAmount());
  }

  double _getActualAmount() {
    return _assets.isNotEmpty
        ? _assets
            .map((e) => e.actualPrice ?? 0.0)
            .reduce((amountOne, amountTwo) => amountOne + amountTwo)
        : 0.0;
  }

  double _getInitial() {
    return _userWalletInformation?.cryptos
            .map((e) => e.initialUsdDollar)
            .reduce((value, element) => value + element) ??
        0.0;
  }

  double _getCurrentAmount() {
    return _assets.isNotEmpty
        ? _assets
            .map((e) => e.value ?? 0.0)
            .reduce((amountOne, amountTwo) => amountOne + amountTwo)
        : 0.0;
  }

  String get liquidityFormatted =>
      CurrencyHelper.formatUsd(_getCurrentAmount() - _getInvestedCapital());

  double? _initialAmount;

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

  Future<void> _initAssetTimer() async {
    showProgress();

    await _getAssets();
    Timer.periodic(Duration(seconds: 10), (timer) async {
      _getAssets();
    });
  }

  Future<void> _getAssets() async {
    final coins = _userWalletInformation?.cryptos.map((e) => e.crypto).toList();
    final assets = await dataManager.getAssets(
      coins: coins,
      wallet: _userWalletInformation,
    );

    if (assets.isNotEmpty) {
      final mapAssets = assets.map((newAsset) {
        final itemFound = _assets.firstWhereOrNull(
            (currentAsset) => currentAsset.coin == newAsset.coin);

        if (itemFound != null) {
          newAsset.isExpanded = itemFound.isExpanded;
        }

        return newAsset;
      }).toList();

      _assets = mapAssets;
      hideProgress();
    }
  }
}
