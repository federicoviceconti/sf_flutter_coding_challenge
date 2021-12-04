import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper {
  static Widget getSvg(
    final String name, {
    final double? width,
    final double? height,
  }) {
    return SvgPicture.asset(
      "assets/$name.svg",
      width: width,
      height: height,
    );
  }
}
