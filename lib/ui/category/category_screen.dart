import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/category_provider.dart';
import 'package:ecommerce_app/ui/admin/add_category/add_category.dart';
import 'package:ecommerce_app/ui/admin/add_category/update_category.dart';
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
      floatingActionButton: Visibility(
        visible: context.read<AuthProvider>().isvisible,
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
                  builder: (context) => const CategoryADD(),
                ));
          },
          child: const Text(
            "Add Categories",
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("data not found"),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      children: [
                        ...List.generate(snapshot.data!.length, (index) {
                          CategoryModel categoryModel = snapshot.data![index];
                          return Container(
                            height: MediaQuery.of(context).size.height / 10,
                            margin: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: ListTile(
                                trailing: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCategory(
                                                      categoryModel:
                                                          categoryModel),
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: const Icon(Icons.delete)),
                                  ],
                                ),
                                leading: CachedNetworkImage(
                                    imageUrl: categoryModel.imageUrl,
                                    placeholder: (context, url) =>
                                        const ShimmerPhoto(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error,
                                            color: Colors.red),
                                    width: 140.w,
                                    fit: BoxFit.cover),
                                title: Text(categoryModel.categoryName),
                                subtitle: Text(categoryModel.description),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.categoryDetail,
                                      arguments: categoryModel.categoryId);
                                },
                              ),
                            ),
                          );
                        })
                      ],
                    )
                  : const Center(
                      child: Text('Data Empty'),
                    );
            }
            return const Center(
              child: Text('Null'),
            );
          }),
    );
  }
}
