import 'package:flutter/material.dart';
import 'package:new_e_mart/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(16),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
