import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        const Divider(),
        "Are you sure you want to exit"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                title: "Yes",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                }),
            10.widthBox,
            ourButton(
                title: "No",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                })
          ],
        )
      ],
    ).box.padding(const EdgeInsets.all(12)).rounded.color(lightGrey).make(),
  );
}
