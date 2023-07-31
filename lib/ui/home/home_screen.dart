import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/ui/admin/add_products/add_products.dart';

import 'package:ecommerce_app/ui/home/widget/category_name.dart';
import 'package:ecommerce_app/utils/size_box_extension.dart';

import 'package:ecommerce_app/widget/savat.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/models/product/product_model.dart';
import '../../providers/category_provider.dart';
import '../../widget/global_like_button.dart';
import '../../widget/shimmer_category.dart';
import '../../widget/shimmer_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: context.read<AuthProvider>().isadminvisible,
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Addproducts(),
                ));
          },
          child: const Text(
            "Add Products",
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        const CategoryNameInHome(),
        Expanded(
          child: StreamBuilder(
              stream: context.read<CategoryProvider>().getAllProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const ShimmerProductScreen();
                } else if (snapshot.hasData) {
                  return snapshot.data!.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.55,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, int index) {
                                ProductModel productModel =
                                    snapshot.data![index];
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ...List.generate(
                                            productModel.productImages.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: SizedBox(
                                                  width: 150.w,
                                                  height: 230.h,
                                                  child: CachedNetworkImage(
                                                      imageUrl: productModel
                                                          .productImages[index],
                                                      placeholder: (context,
                                                              url) =>
                                                          const ShimmerPhoto(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.red),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GlobalLikeButton()),
                                        ],
                                      ),
                                      Text(
                                        productModel.productName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        productModel.createdAt
                                            .toString()
                                            .substring(0, 16),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      SavatButton(productModel: productModel)
                                    ],
                                  ),
                                );
                              }),
                        )
                      : const ShimmerProductScreen();
                }
                return const ShimmerProductScreen();
              }),
        ),
      ]),
    );
  }
}
