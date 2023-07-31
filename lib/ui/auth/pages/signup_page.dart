import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  onTap: () async {
                    

                    context.read<AuthProvider>().signUpUser(context);
                  }),
              SizedBox(
                height: 30.h,
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
