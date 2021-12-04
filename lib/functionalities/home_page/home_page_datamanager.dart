import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_service.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/expandable_asset_model.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/user_wallet_information.dart';
import 'package:collection/collection.dart';

import 'model/crypto_coin.dart';

class HomePageDataManager {
  final HomePageService service;

  HomePageDataManager({
    required this.service,
  });

  Future<UserWalletInformation?> getUserInfo() async {
    return UserWalletInformation(
      cryptos: [
        CryptoAmount(
          crypto: CryptoCoin.bitcoin,
          amount: 1,
          initialUsdDollar: 300.2,
        ),
        CryptoAmount(
          crypto: CryptoCoin.ethereum,
          amount: 2,
          initialUsdDollar: 100.22,
        ),
        CryptoAmount(
          crypto: CryptoCoin.dogecoin,
          amount: 250,
          initialUsdDollar: 0.00002232,
        ),
      ],
    );
  }

  Future<List<ExpandableAssetModel>> getAssets({
    List<CryptoCoin>? coins,
    UserWalletInformation? wallet,
  }) async {
    final ids = coins != null && coins.isNotEmpty
        ? coins.map((coin) => coin.id).reduce(
            (coin1, coin2) => '$coin1${coin2.isNotEmpty ? ',$coin2' : ''}')
        : null;

    final assetsResponse = await service.getAssets(coinIds: ids);

    if (!assetsResponse.hasError) {
      return assetsResponse.result?.assetDataList.map(
            (asset) {
              final cryptoAmount = wallet?.cryptos.firstWhereOrNull(
                (element) => element.crypto.id == asset.id,
              );

              final priceUsd = double.parse(asset.priceUsd ?? '0.0');
              return ExpandableAssetModel(
                coin: cryptoAmount?.crypto,
                name: asset.name,
                acronym: asset.symbol,
                value: (cryptoAmount?.amount ?? 0.0) * priceUsd,
                increase: double.parse(asset.changePercent24Hr ?? '0.0'),
                variation: asset.changePercent24Hr,
                actualPrice: priceUsd,
                inWallet: cryptoAmount?.amount ?? 0.0,
              );
            },
          ).toList() ??
          [];
    } else {
      return const [];
    }
  }
}
