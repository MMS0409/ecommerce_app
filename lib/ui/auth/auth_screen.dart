import 'package:ecommerce_app/ui/auth/pages/login_page.dart';
import 'package:ecommerce_app/ui/auth/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(0, 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginPage = true;
                          });
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: isLoginPage ? 40.sp : 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Montserrat"),
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Visibility(
                      visible: isLoginPage,
                      child: Container(
                        width: 75.w,
                        height: 5.h,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginPage = false;
                          });
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: !isLoginPage ? 40.sp : 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Montserrat"))),
                    SizedBox(
                      height: 15.h,
                    ),
                    Visibility(
                      visible: !isLoginPage,
                      child: Container(
                        width: 75.w,
                        height: 5.h,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            isLoginPage
                ? LoginPage(
                    onChanged: () {
                      setState(() {
                        isLoginPage = false;
                      });
                    },
                  )
                : SignUpScreen(
                    onChanged: () {
                      setState(() {
                        isLoginPage = true;
                      });
                    },
                  ),
            Visibility(
              visible: context.watch<AuthProvider>().isLoading,
              child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ));
  }
}
