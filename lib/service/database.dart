import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods
{
  Future addUserDetails(Map<String,dynamic> userInfoMap,String id)async
  {
    return await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
  }

  Future addUserOrderDetails(Map<String,dynamic> userOrderMap,String id,String orderId)async
  {
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Orders").doc(orderId).set(userOrderMap);
  }

  Future addAdminOrderDetails(Map<String,dynamic> userOrderMap,String orderId)async
  {
    return await FirebaseFirestore.instance.collection("Orders").doc(orderId).set(userOrderMap);
  }
  Future<Stream<QuerySnapshot>> getUserOrders(String id) async
  {
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Orders").snapshots();
  }
  Future<QuerySnapshot> getUserWalletByEmail(String email) async
  {
    return await FirebaseFirestore.instance.collection("users").where("Email",isEqualTo: email).get();
  }

Future updateUserWallet(String amount,String id) async
{
  return await FirebaseFirestore.instance.collection("users").doc(id).update(
      {"Wallet":amount});
}
  Future<Stream<QuerySnapshot>> getAdminOrders() async
  {
    return await FirebaseFirestore.instance.collection("Orders").where("Status",isEqualTo:"Pending").snapshots();
  }

  Future updateAdminOrder(String id) async
  {
    return await FirebaseFirestore.instance.collection("Orders").doc(id).update(
        {"Status":'Delivered'});
  }

  Future updateUserOrder(String userId,String docsid) async
  {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(docsid)
        .update(
        {"Status":'Delivered'});
  }

  Future<Stream<QuerySnapshot>> getAllUsers() async
  {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }
}