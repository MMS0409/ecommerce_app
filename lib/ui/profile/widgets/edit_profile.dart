import 'dart:io';
import 'package:ecommerce_app/ui/auth/widgets/global_text_fields.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../providers/profiles_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});



  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _imageFile;
  String? _imageUrl;

  Future<void> _pickImage() async {
    XFile? pickedFile = await pickImage();
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    String? downloadUrl = await uploadImageToFirebase(_imageFile);
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  Future<String?> uploadImageToFirebase(XFile? imageFile) async {
    if (imageFile == null) return null;

    try {
      // Create a unique filename for the image using the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to the Firebase Storage bucket
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      // Upload the image to Firebase Storage
      await ref.putFile(File(imageFile.path));

      // Get the download URL of the uploaded image
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error picking image: $e');
    }

    return pickedFile;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalTextField(
                  hintText: "Display Name",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,

                  controller: context.read<ProfileProvider>().nameController, icon: Icons.person,
                ),
                // TextButton(
                //   onPressed: () {
                //
                //   },
                //   child: const Text("Update name"),
                // ),
                GlobalTextField(
                  hintText: "Email Update",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().emailController, icon: Icons.email,
                ),

                ElevatedButton(onPressed: (){
                 _pickImage();
                }, child: const Text('Select image')),
                if (_imageUrl != null) Text('Download URL: $_imageUrl'),
                // TextButton(
                //   onPressed: () {
                //
                //   },
                //   child: const Text("Update email"),
                // ),
                TextButton(
                  onPressed: () {
                    context.read<ProfileProvider>().updateUsername(context);
                    context.read<ProfileProvider>().updateEmail(context);
                    // context.read<ProfileProvider>().updateUserImage(context,
                    //     "https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
                  },
                  child: const Text("Update profile image"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

