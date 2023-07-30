import 'dart:io';
import 'package:ecommerce_app/ui/auth/widgets/global_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String? _imageUrl;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String?> uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(File(imageFile.path));

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _uploadImage() async {
    String? downloadUrl = await uploadImageToFirebase(image);
    setState(() {
      _imageUrl = downloadUrl;
    });
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
                  controller: context.read<ProfileProvider>().nameController,
                  icon: Icons.person,
                ),
                GlobalTextField(
                  hintText: "Email Update",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().emailController,
                  icon: Icons.email,
                ),
                image == null ? Text('') : Image.file(image!,height: 70,),
                ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text('Select image')),
                ElevatedButton(
                    onPressed: () {
                      pickCamera();
                    },
                    child: const Text('Select camera')),
                TextButton(
                  onPressed: () {
                    _uploadImage();
                    context.read<ProfileProvider>().updateUsername(context);
                    context.read<ProfileProvider>().updateEmail(context);
                    context
                        .read<ProfileProvider>()
                        .updateUserImage(context, _imageUrl!);
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
