import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/category_screen/categories_detail.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoriesDetail(title: title));
  });
}
