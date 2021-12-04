import 'package:flutter/material.dart';

import 'base_text.dart';

class LightText extends BaseText {
  LightText(
    String text, {
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    TextAlign? align,
  }) : super(
          text,
          fontWeight: FontWeight.w200,
          fontSize: fontSize,
          color: color,
          overflow: overflow,
          align: align,
        );
}
