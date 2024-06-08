import 'package:new_e_mart/consts/consts.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

//  get product according to categories
  static getProduct(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProduct(title) {
    return firestore
        .collection(productsCollection)
        .where("p_subcategory", isEqualTo: title)
        .snapshots();
  }

//  get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

//delete doc from cart
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

//get all chat message
  static getChatMsg(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrder() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static getallProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where("is_featured", isEqualTo: true)
        .get();
  }

  static searchProduct(title) {
    return firestore
        .collection(productsCollection)
        // .where("p_name", isLessThanOrEqualTo: title)
        .get();
  }
}
