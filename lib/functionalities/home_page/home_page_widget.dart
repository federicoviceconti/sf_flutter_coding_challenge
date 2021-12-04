import 'package:flutter/material.dart';
import 'package:sf_flutter_coding_challenge/common/images/coin_svg.dart';
import 'package:sf_flutter_coding_challenge/common/images/image_helper.dart';
import 'package:sf_flutter_coding_challenge/common/theme/app_color.dart';
import 'package:sf_flutter_coding_challenge/common/widget/base_state.dart';
import 'package:sf_flutter_coding_challenge/common/widget/base_widget.dart';
import 'package:sf_flutter_coding_challenge/common/widget/text/heavy_text.dart';
import 'package:sf_flutter_coding_challenge/common/widget/text/medium_text.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends BaseState<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: _buildBody(),
      bottom: _buildBottomLayout(),
      safeTop: true,
      safeBottom: true,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        _buildPositionList(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColor.backgroundColor,
      child: Column(
        children: [
          MediumText(localizations.homepageTitleMyWallet),
          SizedBox(height: 4.0),
          HeavyText('\$23.626,05'),
          MediumText(
            '+\$3.626,05 (+18,1%)',
            color: AppColor.greyTextColor,
          ),
          SizedBox(height: 20.0),
          _buildRowMediumHeavyLabel(
              localizations.homepageResidualLiquidity, '\$1.000,00'),
          SizedBox(height: 4.0),
          _buildRowMediumHeavyLabel(
              localizations.homepageInvestedCapital, '\$22.626,05'),
        ],
      ),
    );
  }

  Widget _buildPositionList() {
    return Column(
      children: [
        _buildPositionListTitle(),
        _buildPositionListView(),
      ],
    );
  }

  Widget _buildPositionListTitle() {
    return Text(localizations.homepageMyPositions);
  }

  Widget _buildPositionListView() {
    return ListView.builder(
      itemBuilder: _buildPositionItemList,
      itemCount: 2,
    );
  }

  Widget _buildPositionItemList(BuildContext context, int index) {
    return Column(
      children: [
        _buildRowPositionValue(
            localizations.homepageCoinItemActualPrice, '\$4.345,00'),
        _buildRowPositionValue(
          localizations.homepageCoinItemVariation,
          '\$2.123,00 (-3,33%)',
        ),
        _buildRowPositionValue(
          localizations.homepageCoinItemInWallet,
          '3',
        ),
        _buildRowPositionValue(
          localizations.homepageCoinItemPositionValue,
          '\$19.000,00',
        ),
      ],
    );
  }

  Widget _buildRowPositionValue(String label, String value) {
    return Row(
      children: [
        Flexible(child: Text(label)),
        Flexible(child: Text(value)),
      ],
    );
  }

  Widget _buildRowMediumHeavyLabel(String label, String value) {
    return Row(
      children: [
        MediumText(
          label,
          color: AppColor.greyTextColor,
        ),
        SizedBox(width: 8.0),
        HeavyText(
          value,
          color: AppColor.greyTextColor,
        ),
      ],
    );
  }

  Widget _buildBottomLayout() {
    return CoinSvg.logoImage;
  }
}
