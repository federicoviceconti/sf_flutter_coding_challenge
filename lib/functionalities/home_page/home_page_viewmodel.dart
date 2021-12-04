import 'package:sf_flutter_coding_challenge/common/mixin/loader_mixin.dart';
import 'package:sf_flutter_coding_challenge/common/provider/base_notifier.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_datamanager.dart';
import 'package:sf_flutter_coding_challenge/functionalities/home_page/model/expandable_asset_model.dart';

class HomePageViewModel extends BaseNotifier with LoaderMixin {
  final HomePageDataManager dataManager;

  List<ExpandableAssetModel> _assets = [];

  HomePageViewModel({
    required this.dataManager,
  });

  void init() async {
    showProgress();
    _assets.clear();
    _assets = await dataManager.getAssets();
    hideProgress();
  }

  void onAssetItemTap(int index) {
    _assets[index].isExpanded = !_assets[index].isExpanded;
    notifyListeners();
  }

  List<ExpandableAssetModel> get assets => _assets;
}
