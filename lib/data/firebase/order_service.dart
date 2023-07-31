import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';

import '../models/universal_data.dart';

class OrderService {
  static Future<UniversalData> addOrders(
      {required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder = await FirebaseFirestore.instance
          .collection("orders")
          .add(orderModel.toJson());

      await FirebaseFirestore.instance
          .collection("orders")
          .doc(newOrder.id)
          .update({
        "orderId": newOrder.id,
      });

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> updateOrders(
      {required OrderModel orderModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderModel.productId)
          .update(orderModel.toJson());

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  static Future<UniversalData> deleteProduct(
      {required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
