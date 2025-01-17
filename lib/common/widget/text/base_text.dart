import 'package:flutter/material.dart';
import 'package:sf_flutter_coding_challenge/common/theme/app_color.dart';

abstract class BaseText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? align;

  const BaseText(
    this.text, {
    Key? key,
    this.align,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColor.primaryColor,
        overflow: overflow,
      ),
      textAlign: align,
    );
  }
}
