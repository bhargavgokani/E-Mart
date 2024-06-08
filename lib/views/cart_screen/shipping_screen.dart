import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/controllers/cart_controller.dart';
import 'package:new_e_mart/views/cart_screen/payment_mehtod.dart';
import 'package:new_e_mart/widgets_common/custom_textfield.dart';
import 'package:new_e_mart/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: "Shipping Info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 10 &&
                controller.phoneController.text.length == 10) {
              Get.to(() => PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form correctly");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
