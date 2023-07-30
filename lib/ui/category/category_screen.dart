import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/category/category_model.dart';
import '../../utils/ui_utils/custom_circular.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: Center(
          child: StreamBuilder(
              stream: context.read<CategoryProvider>().getCategories(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("data not found"),
                  );
                }
                if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? ListView(
                          children: [
                            ...List.generate(snapshot.data!.length, (index) {
                              CategoryModel categoryModel =
                                  snapshot.data![index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.teal, width: 1.0),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.network(categoryModel.imageUrl),
                                  title: Text(categoryModel.categoryName),
                                  subtitle: Text(categoryModel.description),
                                  onTap: () {},
                                ),
                              );
                            })
                          ],
                        )
                      : const Center(child:CustomCircularProgressIndicator());
                }
                return const Center(child: CustomCircularProgressIndicator());
              })),
    );
  }
}
