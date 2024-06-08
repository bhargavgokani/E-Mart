import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/order_screen/components/order_place_details.dart';
import 'package:new_e_mart/views/order_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: true,
                // data['order_place'],
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirm",
                showDone: false,
                // data['order_confirm'],
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.local_shipping,
                title: "On Delivery",
                showDone: false,
                // data['order_on_delivery'],
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Delivered",
                showDone: false,
                // data['order_on_delivered'],
              ),
              const Divider(),
              // 10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    title1: "Order Code",
                    title2: "Shipping Method",
                    // d1: data['order_code'],
                    // d2: data['shipping_method']
                  ),
                  orderPlaceDetails(
                    title1: "Order Date",
                    title2: "Payment Method",
                    // d1: intl.DateFormat()
                    //     .add_yMd()
                    //     .format((data['order_date'].toDate())),
                    // d2: data['payment_method']
                  ),
                  orderPlaceDetails(
                      title1: "Payment Status",
                      title2: "Delivery Status",
                      d1: "Unpaid",
                      d2: "Order Placed"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "Modi".text.make(),
                            // "${data['order_by_name']}".text.make(),
                            // "${data['order_by_email']}".text.make(),
                            // "${data['order_by_address']}".text.make(),
                            // "${data['order_by_city']}".text.make(),
                            // "${data['order_by_state']}".text.make(),
                            // "${data['order_by_phone']}".text.make(),
                            // "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "15000".text.color(redColor).make(),
                              // "${data['total_amount']}".text.color(redColor).make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product".text.fontFamily(semibold).makeCentered(),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(1,
                    // data['orders'].length,
                    (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        // title1: data['orders'][index]['title']
                        // title2: data['orders'][index]['tprice'],
                        title1: "Beauty Box",
                        title2: "15000",
                        // d1: "${data['orders'][index]['qty']}x",
                        d2: "Refundable",
                        d1: "1x",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child:
                            Container(width: 30, height: 20, color: Colors.red
                                // Color(data['orders'][index]['color'],)
                                ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
