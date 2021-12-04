import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/crypto_coin.dart';

class UserWalletInformation {
  final List<CryptoAmount> cryptos;

  UserWalletInformation({
    required this.cryptos,
  });
}

class CryptoAmount {
  final CryptoCoin crypto;
  final double amount;
  final double initialUsdDollar;

  CryptoAmount({
    required this.crypto,
    required this.amount,
    required this.initialUsdDollar,
  });
}
