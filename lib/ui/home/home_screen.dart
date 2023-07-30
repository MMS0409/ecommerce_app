import 'package:ecommerce_app/utils/size_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/product/product_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/category_provider.dart';
import '../../utils/ui_utils/custom_circular.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        ProductModel productModel = snapshot.data![index];
                        return Container(
                        margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [


                              ...List.generate(
                                productModel.productImages.length,
                                (index) =>
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        heightFactor: 1,
                                        child:Image.network(
                                          productModel.productImages[index],
                                        ),
                                      ),
                                    ),
                              ),
                              Text(
                                productModel.description,
                              ),
                              Text(
                                productModel.createdAt.toString(),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CustomCircularProgressIndicator(),
                    );
            }
            return Center(
              child: Text("sjhdbchfvk"),
            );
          }),
    );
  }
}
