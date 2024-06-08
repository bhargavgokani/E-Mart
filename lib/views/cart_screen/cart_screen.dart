import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/controllers/cart_controller.dart';
import 'package:new_e_mart/services/firestore_services.dart';
import 'package:new_e_mart/views/cart_screen/shipping_screen.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';

import '../../widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
          width: context.screenWidth - 60,
          child: ourButton(
              onPress: () {
                Get.to(() => ShippingDetails());
              },
              textColor: whiteColor,
              color: redColor,
              title: "Proceed to shipping"),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
          backgroundColor: whiteColor,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price :"
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        )
                      ],
                    )
                        .box
                        .roundedSM
                        .width(context.screenWidth - 60)
                        .color(lightGolden)
                        .padding(EdgeInsets.all(12))
                        .make(),
                    10.heightBox,
                  ],
                ),
              );
            }
          },
        ));
  }
}
