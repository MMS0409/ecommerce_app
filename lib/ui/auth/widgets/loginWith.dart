import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginWith extends StatelessWidget {
  const LoginWith({super.key, required this.title, required this.image, required this.voidCallback});

  final String title;
  final String image;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: voidCallback,
      child: Container(
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(image),
              Text(title, style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: "Montserrat"),),
            ],
          ),
        ),
      ),
    );
  }
}
