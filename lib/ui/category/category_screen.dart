import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/ui/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/models/category/category_model.dart';
import '../../widget/shimmer_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasError) {
              return Center(
                child: Text("data not found"),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                  children: [
                        ...List.generate(snapshot.data!.length, (index) {
                          CategoryModel categoryModel =
                              snapshot.data![index];
                          return Container(
                            height: MediaQuery.of(context).size.height /10,
                            margin: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color: Colors.teal, width: 1.0),
                            ),
                            child: Center(
                              child: ListTile(
                                leading:Image.network(
                                  categoryModel.imageUrl,
                                ),
                                title: Text(categoryModel.categoryName),
                                subtitle: Text(categoryModel.description),
                                onTap: () {
                                  Navigator.pushNamed(context, RouteNames.categoryDetail,arguments:categoryModel.categoryId);
                                },
                              ),
                            ),
                          );
                        })
                      ],
                    )
                  : const ShimmerCategoriesScreen();
            }
            return const ShimmerCategoriesScreen();
          }),
    );
  }

}
