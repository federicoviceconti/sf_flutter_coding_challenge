import 'package:intl/intl.dart';
import 'package:sf_flutter_coding_challenge/common/utils/currency_helper.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/crypto_coin.dart';

class ExpandableAssetModel {
  bool isExpanded;
  final CryptoCoin? coin;
  final String? name;
  final String? acronym;
  final double? value;
  final double? increase;
  final double? actualPrice;
  double? variation;
  final double? inWallet;

  ExpandableAssetModel({
    this.coin,
    this.name,
    this.acronym,
    this.value,
    this.increase,
    this.actualPrice,
    this.variation,
    this.inWallet,
    this.isExpanded = false,
  });

  String get valueFormatted => '${_formatCurrency(value)}';

  String get variationFormatted => '${variation?.toStringAsFixed(2)}%';

  String get actualPriceFormatted => '${_formatCurrency(actualPrice)}';

  String get increaseFormatted => '${_formatCurrency(increase)}';

  String _formatCurrency(double? value) {
    return CurrencyHelper.formatUsd(value ?? 0.0);
  }
}
