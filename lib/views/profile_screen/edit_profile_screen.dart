import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/profile_screen/profile_controller.dart';
import 'package:new_e_mart/widgets_common/bg_widget.dart';
import 'package:new_e_mart/widgets_common/custom_textfield.dart';
import 'package:new_e_mart/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passwordController.text = data['password'];
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        elevation: 0,
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image url and controller path is empty
            data['imgUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 80,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                //if data is not empty but controller path is empty
                : data['imgUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imgUrl'],
                        width: 80,
                        fit: BoxFit.cover,
                      )
                    //if both are empty
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 80,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
              color: redColor,
              onPress: () {
                Get.find<ProfileController>().changeImage(context);
              },
              textColor: whiteColor,
              title: "Change",
            ),
            const Divider(),
            // 5.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextField(
                controller: controller.oldpasswordController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextField(
                controller: controller.newpasswordController,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            30.heightBox,
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: redColor,
                      onPress: () async {
                        controller.isLoading(true);

                        //if image is not selected

                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImgLink = data['imgUrl'];
                        }
                        //if old password matches with database
                        if (data['password'] ==
                            controller.oldpasswordController.text) {
                          await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpasswordController.text,
                              newpassword:
                                  controller.newpasswordController.text);
                          await controller.updateProfile(
                              name: controller.nameController.text,
                              password: controller.newpasswordController.text,
                              imgUrl: controller.profileImgLink);
                          VxToast.show(context, msg: "Profile Updated");
                        } else {
                          VxToast.show(context, msg: "Wrong old password");
                          controller.isLoading(false);
                        }
                        // } catch (e) {
                        //   VxToast.show(context, msg: e.toString());
                        //   controller.isLoading(false);
                        // }
                      },
                      textColor: whiteColor,
                      title: "Save",
                    ),
                  ),
          ],
        )
            .box
            .shadowSm
            .white
            .padding(const EdgeInsets.all(16))
            .rounded
            .margin(const EdgeInsets.only(top: 50, left: 15, right: 15))
            .make(),
      ),
    ));
  }
}
