import 'package:demo_task/ui/res/color_resources.dart';
import 'package:flutter/material.dart';

Text getSmallText(
  String text, {
  bool bold = false,
  bool isCenter = false,
  FontWeight weight = FontWeight.w400,
  double fontSize = 16,
  Color color = colorPrimary,
  int lines = 1,
}) {
  return Text(
    text,
    maxLines: lines,
    textAlign: isCenter ? TextAlign.center : TextAlign.start,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
    ),
    overflow: TextOverflow.ellipsis,
  );
}
