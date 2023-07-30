import 'dart:io';

import 'package:ecommerce_app/data/models/category/category_model.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/ui/admin/add_category/upload_img.dart';
import 'package:ecommerce_app/ui/auth/widgets/global_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CategoryADD extends StatefulWidget {
  const CategoryADD({super.key});

  @override
  State<CategoryADD> createState() => _CategoryADDState();
}

class _CategoryADDState extends State<CategoryADD> {
  XFile? _imageFile;
  String? _imageUrl;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Add"),
      ),
      body: Container(
        child: ListView(
          children: [
            GlobalTextField(
                hintText: "Add Category name",
                textAlign: TextAlign.start,
                controller:
                    context.read<CategoryProvider>().categoryNamecontroller),
            GlobalTextField(
                hintText: "Add Category description",
                maxlines: 5,
                textAlign: TextAlign.start,
                controller:
                    context.read<CategoryProvider>().categoryDesccontroller),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_imageFile != null)
                  Image.file(
                    File(
                      _imageFile!.path,
                    ),
                    height: 70,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: const Text('Upload Image'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(_imageUrl);
                    if (context
                            .read<CategoryProvider>()
                            .categoryNamecontroller
                            .text
                            .isNotEmpty &&
                        context
                            .read<CategoryProvider>()
                            .categoryDesccontroller
                            .text
                            .isNotEmpty &&
                        _imageUrl != null) {
                      context.read<CategoryProvider>().addCategory(
                            context: context,
                            categoryModel: CategoryModel(
                              categoryId: '',
                              categoryName: context
                                  .read<CategoryProvider>()
                                  .categoryNamecontroller
                                  .text,
                              description: context
                                  .read<CategoryProvider>()
                                  .categoryDesccontroller
                                  .text,
                              imageUrl: _imageUrl!,
                              createdAt: DateTime.now().toString(),
                            ),
                          );
                    }
                  },
                  child: const Text(
                    "Add Category",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
