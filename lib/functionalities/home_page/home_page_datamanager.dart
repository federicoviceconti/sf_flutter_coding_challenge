import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_service.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/expandable_asset_model.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/user_information.dart';

class HomePageDataManager {
  final HomePageService service;

  HomePageDataManager({
    required this.service,
  });

  Future<UserInformation?> getUserInfo() async {
    return null;
  }

  Future<List<ExpandableAssetModel>> getAssets() async {
    return [
      ExpandableAssetModel(
        name: 'BITCOIN',
        acronym: 'BTC',
        value: '12345',
        increase: '+1234',
        actualPrice: '124314',
        variation: '1234',
        inWallet: '3',
        positionValue: '1234.22',
      ),
      ExpandableAssetModel(
        name: 'BITCOIN',
        acronym: 'BTC',
        value: '12345',
        increase: '+1234',
        actualPrice: '124314',
        variation: '1234',
        inWallet: '3',
        positionValue: '1234.22',
      ),
      ExpandableAssetModel(
        name: 'BITCOIN',
        acronym: 'BTC',
        value: '12345',
        increase: '+1234',
        actualPrice: '124314',
        variation: '1234',
        inWallet: '3',
        positionValue: '1234.22',
      ),
      ExpandableAssetModel(
        name: 'BITCOIN',
        acronym: 'BTC',
        value: '12345',
        increase: '+1234',
        actualPrice: '124314',
        variation: '1234',
        inWallet: '3',
        positionValue: '1234.22',
      ),
    ];
  }
}
