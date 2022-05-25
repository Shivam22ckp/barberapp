import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserAdmin() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future addAddShopDetail(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .set(userInfoMap);
  }

  updateaddshopdetail(Map<String, dynamic> userInfoMap, String id, String id1) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .update(userInfoMap);
  }

  Future addAddShopBarcode(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .collection("Barcode")
        .add(userInfoMap);
  }

  Future addAddShopReview(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .collection("Barcode")
        .add(userInfoMap);
  }

  Future addShopDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .set(userInfoMap);
  }

  updateshopdetail(String id, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .update(userInfoMap);
  }

  Future addShopGallery(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .collection("Gallery")
        .add(userInfoMap);
  }

  Future addShopReview(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .collection("Review")
        .add(userInfoMap);
  }

  Future addReviewCount(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .collection("Count")
        .add(userInfoMap);
  }

  Future addShopPersonalReview(
      Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .collection("Review")
        .add(userInfoMap);
  }

  Future addUserShopGallery(
      Map<String, dynamic> userInfoMap, String id, String id1) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .collection("Gallery")
        .add(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Id", isEqualTo: id)
        .get();
  }

  Future<Stream<QuerySnapshot>> getUserShops(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .snapshots();
  }

  Future<QuerySnapshot> SearchtheBarber(String date) async {
    return await FirebaseFirestore.instance
        .collection("Shops")
        .where("Key", isEqualTo: date.substring(0, 1).toUpperCase())
        .get();
  }

  Future<Stream<QuerySnapshot>> getShopsGallery(String id) async {
    return FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .collection("Gallery")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserShopsReviews(String id) async {
    return FirebaseFirestore.instance
        .collection("Shops")
        .doc(id)
        .collection("Review")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLocatedShops() async {
    return FirebaseFirestore.instance.collection("Shops").snapshots();
  }

  Future<Stream<QuerySnapshot>> getOwnerShopGallery(
      String id, String id1) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Shops")
        .doc(id1)
        .collection("Gallery")
        .snapshots();
  }

  updateProfile(String id, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(userInfoMap);
  }
}
