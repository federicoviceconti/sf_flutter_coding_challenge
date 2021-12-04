import 'package:flutter/material.dart';

import 'base_text.dart';

class MediumText extends BaseText {
  MediumText(
    String text, {
    double? fontSize,
    Color? color,
    TextOverflow? overflow,
    TextAlign? align,
  }) : super(
          text,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
          color: color,
          overflow: overflow,
          align: align,
        );
}
