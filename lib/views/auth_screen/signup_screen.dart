import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/views/home_screen/home.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              5.heightBox,
              "Join the $appname"
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
                        title: name,
                        hint: nameHint,
                        controller: nameController,
                        isPass: false),
                    customTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                        isPass: false),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: registerWithPh.text.size(12).make(),
                    //   ),
                    // ),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordController,
                        isPass: true),
                    customTextField(
                        title: retypePass,
                        hint: passwordHint,
                        controller: passwordRetypeController,
                        isPass: true),
                    Row(
                      children: [
                        Checkbox(
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    color: fontGrey,
                                    fontFamily: regular,
                                  ),
                                ),
                                TextSpan(
                                  text: "Term and Condition",
                                  style: TextStyle(
                                    color: redColor,
                                    fontFamily: regular,
                                  ),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    color: redColor,
                                    fontFamily: regular,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: redColor,
                                    fontFamily: regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isLoading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then(
                                    (value) {
                                      return controller.storeUserdata(
                                          email: emailController.text,
                                          name: nameController.text,
                                          password: passwordController.text);
                                    },
                                  ).then((value) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  controller.isLoading(false);
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                }
                              }
                            },
                          ).box.width(context.screenWidth).make(),
                    10.heightBox,
                    // wrap into gesture detector of velocity x(onTap) to go back
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Already have an account? ".text.color(fontGrey).make(),
                        "Log in".text.color(redColor).make().onTap(() {
                          Get.back();
                        })
                      ],
                    ),
                    5.heightBox
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(16))
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
