import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sf_flutter_coding_challenge/common/images/coin_svg.dart';
import 'package:sf_flutter_coding_challenge/common/theme/app_color.dart';
import 'package:sf_flutter_coding_challenge/common/widget/base_state.dart';
import 'package:sf_flutter_coding_challenge/common/widget/base_widget.dart';
import 'package:sf_flutter_coding_challenge/common/widget/text/heavy_text.dart';
import 'package:sf_flutter_coding_challenge/common/widget/text/medium_text.dart';
import 'dart:math' as math;

import 'package:sf_flutter_coding_challenge/functionalities/home_page/home_page_viewmodel.dart';

import 'model/expandable_asset_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends BaseState<HomePageWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<HomePageViewModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      body: _buildBody(),
      bottom: _buildBottomLayout(),
      showLoader: Provider.of<HomePageViewModel>(context).showLoader,
      safeTop: true,
      safeBottom: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildPositionList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColor.grayColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediumText(
            localizations.homepageTitleMyWallet,
            fontSize: 26,
          ),
          SizedBox(height: 8.0),
          HeavyText(
            '\$23.626,05',
            fontSize: 26,
          ),
          SizedBox(height: 2.0),
          MediumText(
            '+\$3.626,05 (+18,1%)',
            color: AppColor.greyTextColor,
            fontSize: 18,
          ),
          SizedBox(height: 20.0),
          _buildRowMediumHeavyLabel(
              localizations.homepageResidualLiquidity, '\$1.000,00'),
          SizedBox(height: 8.0),
          _buildRowMediumHeavyLabel(
              localizations.homepageInvestedCapital, '\$22.626,05'),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildPositionList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPositionListTitle(),
          _buildPositionListView(),
        ],
      ),
    );
  }

  Widget _buildPositionListTitle() {
    return MediumText(
      localizations.homepageMyPositions,
      fontSize: 26.0,
    );
  }

  Widget _buildPositionListView() {
    return Consumer<HomePageViewModel>(
      builder: (_, viewModel, __) {
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            final item = viewModel.assets[index];

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => viewModel.onAssetItemTap(index),
              child: _buildPositionItemList(
                ctx,
                item,
              ),
            );
          },
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemCount: viewModel.assets.length,
          separatorBuilder: (_, __) => Divider(
            color: AppColor.dividerColor,
            thickness: 1.2,
          ),
        );
      },
    );
  }

  Widget _buildPositionItemList(
    BuildContext context,
    ExpandableAssetModel asset,
  ) {
    final isExpanded = asset.isExpanded;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildHeaderItem(
                  coinAcronym: asset.acronym,
                  coinName: asset.name,
                  coinValue: asset.value,
                  increase: asset.increase,
                ),
                Visibility(
                  visible: isExpanded,
                  child: _buildExpandedItem(asset),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
            ),
            child: Transform.rotate(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.primaryColor,
              ),
              angle: isExpanded ? _degreeToRad(90) : _degreeToRad(-90),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowPositionValue(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: MediumText(
            label,
            color: AppColor.greyTextColor,
          ),
        ),
        Expanded(
          child: MediumText(
            value,
            color: AppColor.greyTextColor,
            align: TextAlign.right,
          ),
        ),
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
    return Container(
      alignment: Alignment.center,
      height: 30,
      child: CoinSvg.logoImage,
    );
  }

  Widget _buildHeaderItem({
    required String coinAcronym,
    required String coinName,
    required String coinValue,
    required String increase,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          color: AppColor.grayColor,
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeavyText(
                coinAcronym,
                fontSize: 20,
              ),
              SizedBox(height: 4.0),
              MediumText(
                coinName,
                align: TextAlign.end,
                color: AppColor.greyTextColor,
                fontSize: 16,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            HeavyText(
              coinValue,
              fontSize: 20,
            ),
            SizedBox(height: 4.0),
            MediumText(
              increase,
              color: AppColor.greyTextColor,
              align: TextAlign.end,
              fontSize: 16,
            ),
          ],
        ),
      ],
    );
  }

  double _degreeToRad(double degree) => (degree) * math.pi / 180;

  Widget _buildExpandedItem(ExpandableAssetModel asset) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        _buildRowPositionValue(
          localizations.homepageCoinItemActualPrice,
          asset.actualPrice,
        ),
        SizedBox(height: 8.0),
        _buildRowPositionValue(
          localizations.homepageCoinItemVariation,
          asset.variation,
        ),
        SizedBox(height: 8.0),
        _buildRowPositionValue(
          localizations.homepageCoinItemInWallet,
          asset.inWallet,
        ),
        SizedBox(height: 8.0),
        _buildRowPositionValue(
          localizations.homepageCoinItemPositionValue,
          asset.positionValue,
        ),
      ],
    );
  }
}