
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerCategoryName extends StatelessWidget {
  const ShimmerCategoryName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor:  Colors.grey,
          child: SizedBox(
            height: 60,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(5, (index) {

                  return Container(
                      width: 100,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 7,
                              spreadRadius: 1,
                              offset: const Offset(3, 3),
                            )
                          ]),
                      child: Column(
                        children: [
                        ],
                      ));
                }),
              ],
            ),
          ),
      )


    );
  }
}
