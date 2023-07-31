import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/ui/home/widget/category_name.dart';
import 'package:ecommerce_app/widget/shimmer_category.dart';
import 'package:ecommerce_app/widget/shimmer_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (rest of the code remains the same)

      body: Column(
        children: [
          CategoryNameInHome(),
          StreamBuilder(
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
                        childAspectRatio: 0.6,
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
                                          placeholder: (context, url) =>
                                          const ShimmerPhoto(),
                                          errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ), // Closing parenthesis for List.generate
                                ),
                              ],
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
                    },
                  ),
                )
                    : const ShimmerProductScreen();
              }
              return const ShimmerProductScreen();
            },
          ),
        ],
      ),
    );
  }
}
