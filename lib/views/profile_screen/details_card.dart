import 'package:flutter/cupertino.dart';
import 'package:new_e_mart/consts/consts.dart';

Widget detailsCard({
  width,
  String? count,
  String? title,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      5.heightBox,
      count!.text.fontFamily(semibold).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).padding(EdgeInsets.all(4)).height(60).make();
}
