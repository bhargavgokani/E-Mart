import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/consts/lists.dart';
import 'package:new_e_mart/controllers/product_controller.dart';
import 'package:new_e_mart/views/category_screen/categories_detail.dart';
import '../../widgets_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: redColor,
          elevation: 0,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoriesListImages[index],
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    5.heightBox,
                    categoriesList[index]
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(() => CategoriesDetail(title: categoriesList[index]));
                });
              }),
        ),
      ),
    );
  }
}
