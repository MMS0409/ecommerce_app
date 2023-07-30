import 'package:ecommerce_app/ui/category/category_details/categorie_detail.dart';
import 'package:ecommerce_app/ui/profile/widgets/edit_profile.dart';
import 'package:ecommerce_app/ui/route/route_names.dart';
import 'package:ecommerce_app/widget/global_search_view.dart';
import 'package:flutter/material.dart';




class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case RouteNames.categoryDetail:
        return MaterialPageRoute(builder: (_) =>  CategoryDetail(productId: settings.arguments as String));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}