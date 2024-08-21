import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_social_media_app/util/snack_bar/snack_bar.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/view/screen_parent.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/list_.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenPost extends StatefulWidget {
  @override
  _ScreenPostState createState() => _ScreenPostState();
}

class _ScreenPostState extends State<ScreenPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<File?> _imageFile = ValueNotifier<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFile.value = File(pickedFile.path);
      }
    } else if (status.isPermanentlyDenied) {
      CustomSnackBar.showSnackBar(context,
          'Storage permission is required. Please enable it in settings.');
      openAppSettings();
    } else {
      CustomSnackBar.showSnackBar(
          context, 'Storage permission is required to continue');
    }
  }

  void _addPost() {
    if (_imageFile.value != null &&
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      demoPosts.addPost(
        _imageFile.value!.path,
        titleController.text,
        descriptionController.text,
      );
      CustomSnackBar.showSnackBar(context, 'Posted successfuly');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenParentNavigation(userData: const {}),
          ));
    } else {
      CustomSnackBar.showSnackBar(context, 'Please complete all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<File?>(
                  valueListenable: _imageFile,
                  builder: (context, file, _) {
                    return InkWell(
                      onTap: _pickImage,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: file != null
                              ? DecorationImage(
                                  image: FileImage(file), fit: BoxFit.cover)
                              : null,
                        ),
                        child: file == null
                            ? const Icon(Icons.add_a_photo, color: Colors.white)
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  hintText: 'Title',
                  controller: titleController,
                  icon: Icons.title,
                  validator: (value) => Validations.emtyValidation(value),
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  hintText: 'Description',
                  controller: descriptionController,
                  icon: Icons.description,
                  validator: (value) => Validations.emtyValidation(value),
                ),
                const SizedBox(height: 15),
                ButtonWidget(
                  onpressFunction: _addPost, // Add post when button is pressed
                  text: 'Post',
                  colorCheck: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
