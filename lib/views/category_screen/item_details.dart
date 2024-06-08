import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/controllers/product_controller.dart';
import 'package:new_e_mart/views/chat_screen/chat_screen.dart';

import '../../consts/lists.dart';
import '../../widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          backgroundColor: whiteColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color: controller.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        itemCount: data['p_imgs'].length,
                        autoPlay: true,
                        height: 300,
                        viewportFraction: 1.0,
                        aspectRatio: 16 / 9,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_imgs'][index],
                            width: double.infinity,
                            // width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      maxRating: 5,
                      count: 5,
                      size: 20,
                      // stepInt: true,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .size(18)
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "${data['p_seller']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                            5.heightBox,
                            "In House Brand "
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            5.heightBox
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(
                          () {
                            Get.to(
                              () => const ChatScreen(),
                              arguments: [data['p_seller'], data['vedor_id']],
                            );
                          },
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    // 10.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color : ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: const Icon(
                                                Icons.done,
                                                color: whiteColor,
                                              ),
                                            )
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity : "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantitiy.value.text
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    " ${data['p_quantity']} available"
                                        .text
                                        .fontFamily(bold)
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total : ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    //description section
                    "Description : "
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    // button section
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                          itemDetailsList.length,
                          (index) => ListTile(
                                title: itemDetailsList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    //  Product you may also like
                    20.heightBox,
                    productYMAL.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    // copied this from home screen featured product
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP1,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "Laptop 4GB/128GB"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "\$600"
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .padding(EdgeInsets.all(8))
                              .make(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantitiy.value > 0) {
                      controller.addToCart(
                          title: data['p_name'],
                          img: data['p_imgs'][0],
                          tprice: controller.totalPrice.value,
                          sellername: data['p_seller'],
                          color: data['p_colors'][controller.colorIndex.value],
                          qty: controller.quantitiy.value,
                          vedorID: data['vedor_id'],
                          context: context);
                      VxToast.show(context, msg: "Add to cart");
                    } else {
                      VxToast.show(context,
                          msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
