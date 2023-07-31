import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:flutter/material.dart';

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

            




          },
          child: const Text("Add to Cart")),
    );
  }
}
