import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category/category_model.dart';
import '../../../providers/category_provider.dart';
import '../../../utils/colors/app_colors.dart';
import '../../route/route_names.dart';


class CategoryNameInHome extends StatelessWidget {
  const CategoryNameInHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return const Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData){
            return snapshot.data!.isNotEmpty ?
            SizedBox(
              height: 50.h,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(snapshot.data!.length, (index) {
                    CategoryModel categoryModel =
                    snapshot.data![index];
                    return Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.c_111015,width: 1.0),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(child: TextButton(onPressed:(){
                          Navigator.pushNamed(
                              context, RouteNames.categoryDetail,
                              arguments: categoryModel.categoryId);
                        },child: Text(categoryModel.categoryName))));
                  }),
                ],
              ),
            ):
            CircularProgressIndicator();
          }
          return CircularProgressIndicator();
        });
  }
}
