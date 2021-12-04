import 'dart:convert';

import 'package:http/http.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/base_http_response.dart';

class GetAssetsResponse extends BaseHttpResponse {
  final List<AssetData> assetDataList;

  GetAssetsResponse({
    this.assetDataList = const [],
  });

  static GetAssetsResponse fromResponse(Response response) {
    final json = jsonDecode(response.body);
    return GetAssetsResponse(
      assetDataList: AssetData.fromJsonList(json['data']),
    );
  }
}

class AssetData {
  final String? id;
  final String? rank;
  final String? symbol;
  final String? name;
  final String? supply;
  final String? maxSupply;
  final String? marketCapUsd;
  final String? volumeUsd24Hr;
  final String? priceUsd;
  final String? changePercent24Hr;
  final String? vwap24Hr;
  final String? explorer;

  AssetData({
    this.id,
    this.rank,
    this.symbol,
    this.name,
    this.supply,
    this.maxSupply,
    this.marketCapUsd,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
    this.vwap24Hr,
    this.explorer,
  });

  static List<AssetData> fromJsonList(List<dynamic>? json) {
    if (json == null) return const [];

    return json.map((e) => AssetData.fromJson(e)).toList();
  }

  static AssetData fromJson(Map<String, dynamic>? json) {
    return AssetData(
      id: json?['id'],
      rank: json?['rank'],
      symbol: json?['symbol'],
      name: json?['name'],
      supply: json?['supply'],
      maxSupply: json?['maxSupply'],
      marketCapUsd: json?['marketCapUsd'],
      volumeUsd24Hr: json?['volumeUsd24Hr'],
      priceUsd: json?['priceUsd'],
      changePercent24Hr: json?['changePercent24Hr'],
      vwap24Hr: json?['vwap24Hr'],
      explorer: json?['explorer'],
    );
  }
}
