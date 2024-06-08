import 'package:flutter/cupertino.dart';
import 'package:new_e_mart/consts/consts.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 25,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.shadowSm.size(width, height).make();
}
