import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/firebase/profile_service.dart';
import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({required this.profileService}) {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    listenUserChanges();
  }

  final ProfileService profileService;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  User? currentUser;

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<void> updateUsername(
    BuildContext context,
  ) async {
    print(nameController.text.isEmpty);
    String name = nameController.text;

    if (name.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData =
          await profileService.updateUserName(username: name);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }else{
      showMessage(context, 'Name empty');
    }
  }

  Future<void> updateUserImage(BuildContext context, String imagePath) async {
    if (imagePath.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData =
          await profileService.updateUserImage(imagePath: imagePath);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }else{
      showMessage(context, 'Image empty');
    }
  }

  Future<void> updateEmail(BuildContext context) async {

    String email = emailController.text;

    if (email.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData =
      await profileService.updateUserEmail(email: email);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }else{
      showMessage(context, 'Email empty');
    }
  }

  Future<void> updateAll(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;

    if (email.isNotEmpty&&name.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await profileService.updateUserEmail(email: email);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }else{
      showMessage(context, 'Email empty');
    }
  }
}
