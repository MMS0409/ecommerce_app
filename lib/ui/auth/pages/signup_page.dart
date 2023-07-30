import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/images/app_images.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';
import '../widgets/loginWith.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var options = [
    'User',
    'Admin',
  ];
  var _currentItemSelected = "User";
  var role = "User";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 12),
              GlobalTextField(
                hintText: "Username",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().userNameController,
                icon: Icons.person,
              ),
              SizedBox(
                height: 24.h,
              ),
              GlobalTextField(
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().emailController,
                icon: Icons.email,
              ),
              SizedBox(height: 24.h),
              GlobalTextField(
                hintText: "Password",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                obscureText: true,
                controller: context.read<AuthProvider>().passwordController,
                icon: Icons.person,
              ),
              SizedBox(height: 24.h),
              GlobalButton(
                  title: "Sign up",
                  onTap: () {
                    context.read<AuthProvider>().signUpUser(context);
                    context.read<AuthProvider>().signtoFiree(context);
                  }),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoginWith(
                    title: 'Google',
                    image: AppImages.google,
                    voidCallback: () {
                      context.read<AuthProvider>().signInWithGoogle(context);
                    },
                  ),
                  LoginWith(
                    title: 'Facebook',
                    image: AppImages.facebook,
                    voidCallback: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Role : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isDense: true,
                    isExpanded: false,
                    iconEnabledColor: Colors.black,
                    focusColor: Colors.black,
                    items: options.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValueSelected) {
                      setState(() {
                        _currentItemSelected = newValueSelected!;
                        context.read<AuthProvider>().role = newValueSelected;
                      });
                    },
                    value: _currentItemSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

