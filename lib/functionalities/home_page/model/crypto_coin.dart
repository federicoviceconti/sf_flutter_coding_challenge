enum CryptoCoin {
  bitcoin, ethereum, dogecoin
}

extension CryptoCoinExt on CryptoCoin {
  String get id => {
    CryptoCoin.bitcoin: 'bitcoin',
    CryptoCoin.ethereum: 'ethereum',
    CryptoCoin.dogecoin: 'dogecoin',
  }[this]!;
}