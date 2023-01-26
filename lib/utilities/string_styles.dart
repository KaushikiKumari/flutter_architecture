import 'package:flutter/material.dart';
import 'package:flutter_architecture/utilities/constant_strings.dart';

TextStyle textStyle({double? size, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: ConstantStrings.font_family_rubik,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: size ?? ConstantStrings.font_tiny,
      color: color ?? Colors.white);
}
