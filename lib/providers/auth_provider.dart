import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/firebase/auth_service.dart';
import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({required this.firebaseServices}) {
    notifyy();
  }

  final AuthService firebaseServices;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  String? role;

  bool isLoading = false;
  bool isvisible = true;

  notifyy() {
    print(isvisible);
    if (FirebaseAuth.instance.currentUser!.email!.contains(
      "admin",
    )) {
      isvisible = true;
      notifyListeners();
    } else {
      isvisible = false;
      notifyListeners();
    }
    print(isvisible);
  }

  loginButtonPressed() {
    passwordController.clear();
    emailController.clear();
    userNameController.clear();
  }

  signUpButtonPressed() {
    passwordController.clear();
    emailController.clear();
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseServices.signUpUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User signed Up");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> logInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);

    UniversalData universalData =
        await firebaseServices.loginUser(email: email, password: password);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User Logged in");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseServices.logOutUser();

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseServices.signInWithGoogle();

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User Signed Up with Google.");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Teacher") {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Teacher(),
          //   ),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Student(),
          //   ),
          // );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
