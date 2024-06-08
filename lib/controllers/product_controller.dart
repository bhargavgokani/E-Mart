import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_e_mart/consts/consts.dart';
import 'package:new_e_mart/models/category_model.dart';

class ProductController extends GetxController {
  var quantitiy = 0.obs;
  var colorIndex = 0.obs;
  var subcat = [];
  var isFav = false.obs;
  var totalPrice = 0.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantitiy.value < totalQuantity) {
      quantitiy.value++;
    }
  }

  decreaseQuantity() {
    if (quantitiy.value > 0) {
      quantitiy.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantitiy.value;
  }

  addToCart(
      {title, img, tprice, sellername, color, qty, context, vedorID}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "tprice": tprice,
      "qty": qty,
      'vedor_id': vedorID,
      "color": color,
      "added_by": currentUser!.uid
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantitiy.value = 0;
    colorIndex.value = 0;
  }

//   add & remove wishlist
  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contain(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
