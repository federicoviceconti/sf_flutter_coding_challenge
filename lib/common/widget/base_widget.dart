import 'package:flutter/material.dart';
import 'package:sf_flutter_coding_challenge/common/theme/app_color.dart';

class BaseWidget extends StatelessWidget {
  final Widget body;
  final Widget? bottom;
  final bool? safeTop;
  final bool? safeBottom;
  final bool? showLoader;

  const BaseWidget({
    Key? key,
    required this.body,
    this.showLoader,
    this.bottom,
    this.safeTop,
    this.safeBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        top: safeTop ?? false,
        bottom: safeBottom ?? false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: body,
                ),
                _buildBottom(context),
              ],
            ),
            _buildLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2.0,
            spreadRadius: 4.0,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: bottom != null
          ? Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                bottom: 16.0
              ),
              child: bottom,
            )
          : IgnorePointer(),
    );
  }

  Widget _buildLoader(BuildContext context) {
    final hasLoader = showLoader ?? false;
    if (!hasLoader) return IgnorePointer();

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: AppColor.primaryColor.withOpacity(0.2),
        ),
        Center(
          child: CircularProgressIndicator(
            color: AppColor.progressColor,
          ),
        ),
      ],
    );
  }
}
