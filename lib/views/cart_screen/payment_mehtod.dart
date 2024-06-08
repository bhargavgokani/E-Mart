import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/consts/lists.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          title: "Choose Payment Method"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        bottomNavigationBar: controller.placingOrder.value
            ? Center(
                child: loadingIndicator(),
              )
            : SizedBox(
                child: ourButton(
                  onPress: () async {
                    await controller.placeMyOrders(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order place successfully");
                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place my order",
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethods.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4)),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}))
                          : Container(),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .fontFamily(semibold)
                              .white
                              .size(16)
                              .make())
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
