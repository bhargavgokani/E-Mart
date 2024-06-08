import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/consts/lists.dart';
import 'package:new_e_mart/controllers/auth_controller.dart';
import 'package:new_e_mart/services/firestore_services.dart';
import 'package:new_e_mart/views/auth_screen/login_screen.dart';
import 'package:new_e_mart/views/chat_screen/messaging.dart';
import 'package:new_e_mart/views/order_screen/orders_screen.dart';
import 'package:new_e_mart/views/profile_screen/details_card.dart';
import 'package:new_e_mart/views/profile_screen/edit_profile_screen.dart';
import 'package:new_e_mart/views/profile_screen/profile_controller.dart';
import 'package:new_e_mart/views/wishlist_screen/wishlist_screen.dart';
import 'package:new_e_mart/widgets_common/lodingIndicator.dart';
import '../../widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Align(
                        alignment: Alignment.topRight,
                        child:
                            const Icon(Icons.edit, color: whiteColor).onTap(() {
                          controller.nameController.text = data['name'];
                          // controller.passwordController.text = data['password'];
                          Get.to(() => EditProfileScreen(
                                data: data,
                              ));
                        }),
                      ),
                    ),
                    4.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          data['imgUrl'] == null
                              ? Image.asset(
                                  imgProfile2,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imgUrl'],
                                  width: 50,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: "Logout"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make())
                        ],
                      ),
                    ),
                    10.heightBox,
                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                    count: countData[0].toString(),
                                    width: context.screenWidth / 3.4,
                                    title: "in your cart"),
                                detailsCard(
                                    count: countData[1].toString(),
                                    width: context.screenWidth / 3.4,
                                    title: "in your wishlist"),
                                detailsCard(
                                    count: countData[2].toString(),
                                    width: context.screenWidth / 3.4,
                                    title: "Your orders"),
                              ],
                            );
                          }
                        }),
                    10.heightBox,
                    ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const WishlistScreen());
                                      break;
                                    case 1:
                                      Get.to(() => const OrdersScreen());
                                      break;
                                    case 2:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                  }
                                },
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length)
                        .box
                        .white
                        .rounded
                        .margin(const EdgeInsets.all(12))
                        .shadowSm
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
