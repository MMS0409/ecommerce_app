import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/firebase/order_service.dart';
import 'package:ecommerce_app/data/firebase/products_service.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:flutter/material.dart';

import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider(
    this.orderService,
  );

  final OrderService orderService;



  Future<void> addOrders({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await OrderService.addOrders(orderModel: orderModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrders({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await OrderService.updateOrders(orderModel: orderModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteProducts({
    required BuildContext context,
    required String productsId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await ProductService.deleteProduct(productId: productsId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<ProductModel>> getProducts() =>
      FirebaseFirestore.instance.collection("products").snapshots().map(
            (event1) => event1.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
