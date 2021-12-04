import 'package:flutter/cupertino.dart';
import 'package:sf_flutter_coding_challenge/common/widget/text/base_text.dart';

class HeavyText extends BaseText {
  HeavyText(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    TextOverflow? overflow,
  }) : super(
          text,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
          overflow: overflow,
          align: align,
        );
}
