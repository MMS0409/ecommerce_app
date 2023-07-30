import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/profiles_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<ProfileProvider>().currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                  child: Image.network(user?.photoURL ?? '')),
              SizedBox(height: 20.h,),
              Center(
                child: Text(user?.displayName ?? '',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
              ),
              ListTile(
                  onTap: () {
                  },
                  title: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                  onTap: () {
                    context.read<AuthProvider>().logOutUser(context);
                  },
                  title: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black),
                  ),
                trailing: const Icon(Icons.exit_to_app_outlined,color: Colors.red,),
              ),
            ],
          ),
        ));
  }
}
