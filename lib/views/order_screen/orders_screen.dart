import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/order_screen/order_details.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';
import 'components/order_status.dart';
import '../../services/firestore_services.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          title:
              "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrder(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No orders yet".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails());
                        },
                        leading: "${index + 1}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .xl
                            .make(),
                        title: data[index]['order_code']
                            .toString()
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['total_amount']
                            .toString()
                            .numCurrency
                            .text
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .make(),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrderDetails());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
