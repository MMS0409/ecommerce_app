import 'dart:io';

import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:ecommerce_app/providers/products_provider.dart';
import 'package:ecommerce_app/ui/admin/add_category/upload_img.dart';
import 'package:ecommerce_app/ui/admin/add_products/widgets/addButton.dart';
import 'package:ecommerce_app/ui/admin/add_products/widgets/select_cat.dart';
import 'package:ecommerce_app/ui/admin/add_products/widgets/updateButton.dart';
import 'package:ecommerce_app/ui/auth/widgets/global_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Updateproducts extends StatefulWidget {
  Updateproducts({super.key, required this.productModel});
  ProductModel productModel;

  @override
  State<Updateproducts> createState() => _UpdateproductsState();
}

class _UpdateproductsState extends State<Updateproducts> {
  XFile? _imageFile;
  String? _imageUrl;
  String? catID;

  Future<void> _pickImage() async {
    XFile? pickedFile = await pickImage();
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    String? downloadUrl = await uploadImageToFirebase(_imageFile);
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  textInit() {
    context.read<ProductsProvider>().ProductsNamecontroller.text =
        widget.productModel.productName;
    context.read<ProductsProvider>().ProductsDesccontroller.text =
        widget.productModel.description;
    context.read<ProductsProvider>().ProductsCountcontroller.text =
        widget.productModel.count.toString();
    context.read<ProductsProvider>().ProductsCurrencycontroller.text =
        widget.productModel.currency;
    context.read<ProductsProvider>().ProductsPricecontroller.text =
        widget.productModel.price.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    textInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Products"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: ListView(
          children: [
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Add Product name",
                textAlign: TextAlign.start,
                controller:
                    context.read<ProductsProvider>().ProductsNamecontroller),
            SizedBox(height: 10.h),
            GlobalTextField(
                hintText: "Add Product count",
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                controller:
                    context.read<ProductsProvider>().ProductsCountcontroller),
            SizedBox(
              height: 10.h,
            ),
            GlobalTextField(
                hintText: "Add Product description",
                maxlines: 5,
                textAlign: TextAlign.start,
                controller:
                    context.read<ProductsProvider>().ProductsDesccontroller),
            SizedBox(
              height: 10.h,
            ),
            GlobalTextField(
                keyboardType: TextInputType.number,
                hintText: "Add Product Price",
                maxlines: 5,
                textAlign: TextAlign.start,
                controller:
                    context.read<ProductsProvider>().ProductsPricecontroller),
            SizedBox(
              height: 10.h,
            ),
            GlobalTextField(
                hintText: "Add Product Currency",
                maxlines: 5,
                textAlign: TextAlign.start,
                controller: context
                    .read<ProductsProvider>()
                    .ProductsCurrencycontroller),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CategorySelectionWidget(
                          onCategorySelected: (p0) {
                            setState(() {
                              catID = p0;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Choose Category",
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () async {
                    await _pickImage();

                    await _uploadImage();
                  },
                  child: const Text('Upload Image'),
                ),
                const SizedBox(width: 20),
                if (_imageFile != null)
                  Image.file(
                    File(
                      _imageFile!.path,
                    ),
                    height: 70,
                  ),
              ],
            ),
            UpdateProductButton(
              imageUrl: _imageUrl,
              catID: catID,
              productModel: widget.productModel,
              
            ),
          ],
        ),
      ),
    );
  }
}
