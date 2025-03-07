import 'package:flutter/material.dart';

//global UiHelper class
class UiHelper
{
  //static method to return Image widget
  static CustomImage({required String img})
  {
    return Image.asset("assets/images/$img");
  }

  //static method to return Text Widget
static CustomText({required String text,required Color color,required FontWeight fontweight,String? fontfamily,
  required double fontsize})
{
  return Text(
    text,
    style: TextStyle(
        fontSize: fontsize,
        fontFamily: fontfamily ?? "regular",
        fontWeight: fontweight,
        color: color),
  );
}
}