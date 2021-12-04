import 'package:sf_flutter_coding_challenge/common/http/client/coincap_client.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/http_result.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/response/get_assets_response.dart';

class HomePageService {
  final CoinCapClient client;

  HomePageService({
    required this.client,
  });

  Future<HttpResult<GetAssetsResponse>> getAssets({
    String? coinIds,
  }) async {
    return await client.makeGet(
      '/v2/assets',
      queryParameters: {
        'ids': coinIds,
      },
      convertBodyFunc: (response) => GetAssetsResponse.fromResponse(response),
    );
  }
}
