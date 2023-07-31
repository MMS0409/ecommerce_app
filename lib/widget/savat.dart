import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavatButton extends StatefulWidget {
  SavatButton({super.key, required this.productModel});
  ProductModel productModel;

  @override
  State<SavatButton> createState() => _SavatButtonState();
}

class _SavatButtonState extends State<SavatButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          onPressed: () {
            context.read<OrderProvider>().addOrders(
                context: context,
                orderModel: OrderModel(
                    count: 1,
                    totalPrice: 200,
                    orderId: '',
                    productId: widget.productModel.productId,
                    userId: context.read<AuthProvider>().usser!.uid,
                    orderStatus: "waiting",
                    createdAt: DateTime.now().toString(),
                    productName: widget.productModel.productName));
          },
          child: const Text("Add to Cart")),
    );
  }
}
