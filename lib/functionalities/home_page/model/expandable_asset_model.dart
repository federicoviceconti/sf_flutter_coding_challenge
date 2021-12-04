class ExpandableAssetModel {
  bool isExpanded;
  final String name;
  final String acronym;
  final String value;
  final String increase;
  final String actualPrice;
  final String variation;
  final String inWallet;
  final String positionValue;

  ExpandableAssetModel({
    required this.name,
    required this.acronym,
    required this.value,
    required this.increase,
    required this.actualPrice,
    required this.variation,
    required this.inWallet,
    required this.positionValue,
    this.isExpanded = false,
  });
}
