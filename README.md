Simple project for retrieving crypto data from the [CoinCap APIs](https://docs.coincap.io/).

## Run information

Before running this app, you must specify the following environment variables:

- COIN_CAP_BASE_URL (endpoint, which is used to retrieve the data): For production stage you can use
  the following configuration: --dart-define=COIN_CAP_BASE_URL=https://api.coincap.io

- API_KEY: you can get it through [this link](https://coincap.io/api-key)

All the configuration are stored into the config class [lib/common/config](https://github.com/federicoviceconti/sf_flutter_coding_challenge/tree/main/lib/common/config)

## Architecture

For the state management it's used the "Provider" [package](https://pub.dev/packages/provider).
Every page has a view model associated (
eg. [functionalities/home_page](https://github.com/federicoviceconti/sf_flutter_coding_challenge/tree/main/lib/functionalities/home_page))

For HTTP requests it's used the "http" [package](https://pub.dev/packages/http).