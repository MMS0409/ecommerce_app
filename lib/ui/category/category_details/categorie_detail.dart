import 'package:ecommerce_app/data/models/category/category_model.dart';
import 'package:ecommerce_app/data/models/product/product_model.dart';
import 'package:ecommerce_app/widget/global_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/category_provider.dart';
import '../../../utils/ui_utils/custom_circular.dart';
import '../../../utils/ui_utils/loading_dialog.dart';
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
    return Scaffold(appBar: AppBar(title: Text("categorie detail"),),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getProductsByCategoryIdStream(widget.productId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(child: CustomCircularProgressIndicator(),);
            } else if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty ?

              GridView.builder(
                  gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      childAspectRatio:0.6,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.h),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, int index) {
                    ProductModel productModel = snapshot.data![index];
                    return
                     Container(
                       margin: EdgeInsets.all(5.h),
                       child:Column(children: [
                    Stack(children: [
                      ...List.generate(
                        productModel.productImages.length,
                            (index) =>
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.9,
                                child:Image.network(
                                  productModel.productImages[index],
                                ),
                              ),
                            ),
                      ),
                     const  Positioned(
                        right: 0,top: 0,
                          child:  GlobalLikeButton()),
                    ],),
                       ListTile(title:Text( productModel.description,),
                       subtitle: Text( productModel.currency.toString(),),)
                     ],),);

                })
               :const ShimmerCategoryIdScreen() ;
            }
            return const ShimmerCategoryIdScreen();
          }),

    );
  }
}
