import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/consts/lists.dart';
import 'package:new_e_mart/views/auth_screen/signup_screen.dart';
import 'package:new_e_mart/views/home_screen/home.dart';
import 'package:new_e_mart/widgets_common/applogo_widget.dart';
import 'package:new_e_mart/widgets_common/bg_widget.dart';
import 'package:new_e_mart/widgets_common/custom_textfield.dart';
import 'package:new_e_mart/widgets_common/our_button.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Login in to $appname"
                  .text
                  .yellow300
                  .fontFamily(bold)
                  .size(15)
                  .make(),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        title: email,
                        hint: emailHint,
                        isPass: false,
                        controller: controller.emailController),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        isPass: true,
                        controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.size(12).make()),
                    ),
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isLoading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            }).box.width(context.screenWidth).make(),
                    10.heightBox,
                    createNewAccount.text.color(fontGrey).size(10).make(),
                    10.heightBox,
                    ourButton(
                      color: lightGolden,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      },
                    ).box.width(context.screenWidth).make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconsList[index],
                                    width: 30,
                                  ),
                                ),
                              )),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadow
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
