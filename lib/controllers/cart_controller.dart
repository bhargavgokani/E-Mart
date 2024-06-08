import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  //text controller for shipping detail
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 1.obs;

  var placingOrder = false.obs;

  late dynamic productSnapshot;
  var products = [];
  calculate(data) {
    totalP.value = 0;
    for (int x = 0; x < data.length; x++) {
      totalP.value = totalP.value + int.parse(data[x]['tprice'].toString());
    }
  }

//change payment method
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrders({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_place': true,
      'order_confirm': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vedor_id': productSnapshot[i]['vedor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
