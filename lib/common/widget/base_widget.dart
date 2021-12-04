import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget body;
  final Widget? bottom;
  final bool? safeTop;
  final bool? safeBottom;

  const BaseWidget({
    Key? key,
    required this.body,
    this.bottom,
    this.safeTop,
    this.safeBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: safeTop ?? false,
      bottom: safeBottom ?? false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: body,
            ),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    if(bottom == null) return IgnorePointer();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: [
          bottom!,
        ],
      ),
    );
  }
}
