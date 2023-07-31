import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:ecommerce_app/widget/global_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/category_provider.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/custom_circular.dart';
import '../../../widget/savat.dart';
import '../../../widget/shimmer_category.dart';
import '../../../widget/shimmer_category_detail.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("categorie detail"),
      ),
      body: StreamBuilder(
          stream: context
              .read<CategoryProvider>()
              .getProductsByCategoryIdStream(widget.productId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? GridView.builder(
                physics: BouncingScrollPhysics(),
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.53,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        ProductModel productModel = snapshot.data![index];
                        return Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color:  AppColors.c_FDA429,//Colors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ...List.generate(
                                    productModel.productImages.length,
                                    (index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: SizedBox(
                                        width: 160.w,
                                        height:   230.h,
                                        child: CachedNetworkImage(
                                            imageUrl: productModel
                                                .productImages[index],
                                            placeholder: (context, url) =>
                                                const ShimmerPhoto(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error,
                                                        color: Colors.red),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GlobalLikeButton()),
                                ],
                              ),
                              ListTile(
                                title: Text(
                                  productModel.productName,
                                  style:
                                      Theme.of(context).textTheme.titleLarge,
                                ),
                                subtitle:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${ (productModel.createdAt.toString()).substring(0,16)} ||  ",style:Theme.of(context).textTheme.labelMedium ,

                                    ),
                                    Container(
                                        height: 20.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColors.c_838589),
                                        child: Center(child: Text( productModel.count.toString(),style: Theme.of(context).textTheme.bodyMedium,)))
                                  ],
                                ),
                              ),
                              SavatButton(productModel: productModel),
                            ],
                          ),
                        );
                      })
                  : const ShimmerCategoryIdScreen();
            }
            return const ShimmerCategoryIdScreen();
          }),
    );
  }
}
