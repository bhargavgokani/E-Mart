import 'package:flutter/material.dart';
import 'package:new_e_mart/consts/colors.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
