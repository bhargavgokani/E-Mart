import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/controllers/product_controller.dart';
import 'package:new_e_mart/services/firestore_services.dart';
import 'package:new_e_mart/views/category_screen/item_details.dart';
import 'package:new_e_mart/widgets_common/bg_widget.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';

class CategoriesDetail extends StatefulWidget {
  final String title;
  const CategoriesDetail({super.key, required this.title});

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  var controller = Get.find<ProductController>();
  //bcz we are in statefulwidget
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProduct(title);
    } else {
      productMethod = FirestoreServices.getProduct(title);
    }
  }

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            title: widget.title.text.fontFamily(bold).white.make(),
            backgroundColor: redColor,
            elevation: 0,
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                        })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Product found!"
                        .text
                        .color(darkFontGrey)
                        .makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 250),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                5.heightBox,
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
                                    .numCurrency
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(12))
                                .roundedSM
                                .outerShadowSm
                                .make()
                                .onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ));
                            });
                          }));
                }
              },
            ),
          ])),
    );
  }
}
