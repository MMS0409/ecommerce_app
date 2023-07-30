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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: (){

        }, icon:  Icon(Icons.search,size: 30,),)],
      ),
      body: StreamBuilder(
          stream: context.read<CategoryProvider>().getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const ShimmerProductScreen();
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
