import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var featuredList = [];
  var searchController = TextEditingController();

//  get username
  var username = '';
  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
