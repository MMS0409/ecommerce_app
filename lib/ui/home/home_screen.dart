import 'package:ecommerce_app/widget/global_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/product/product_model.dart';
import '../../providers/category_provider.dart';
import '../../widget/global_like_button.dart';
import '../../widget/shimmer_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String searchText = '';
    var nameProduct =  context.read<CategoryProvider>().getAllProducts();
    // List<String> added = [];
    // added= nameProduct.map((e) => e).toList() as List<String>;
    // print("====================================================================${added}");
    List<String> added = ["fvdsv","sdfvsdf"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: ()async{
          searchText = await showSearch(context: context, delegate: GlobalSearchView(suggestionList: );

        }, icon: Icon(Icons.search),
        )]
      ),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const ShimmerProductScreen();
            } else if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
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

                           Stack(children: [
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
                             const Positioned(
                               right: 0,
                                 top: 0,
                                 child: GlobalLikeButton()),
                           ],),
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
                  :const  ShimmerProductScreen();
            }
            return const ShimmerProductScreen();
          }),
    );
  }
}
