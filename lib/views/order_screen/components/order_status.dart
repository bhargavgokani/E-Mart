import 'package:flutter/material.dart';
import 'package:new_e_mart/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          if (showDone)
            const Icon(
              Icons.done,
              color: redColor,
            )
          else
            Container()
        ],
      ),
    ),
  );
}
