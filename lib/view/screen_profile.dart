import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_social_media_app/network/local_data_base/local_database.dart';
import 'package:mini_social_media_app/network/shared_preferences/shared_pref_model.dart';
import 'package:mini_social_media_app/util/constance/colors.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/util/snack_bar/snack_bar.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/show_dialog.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenProfileState createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final ValueNotifier<File?> _profileImageNotifier = ValueNotifier<File?>(null);

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _profileImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _pickImage,
                  child: ValueListenableBuilder<File?>(
                    valueListenable: _profileImageNotifier,
                    builder: (context, profileImage, child) {
                      return Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: profileImage != null
                              ? DecorationImage(
                                  image: FileImage(profileImage),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: profileImage == null
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.white)
                            : null,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                ButtonWidget(
                  onpressFunction: () => _pickImage,
                  text: 'Update Photo',
                  colorCheck: true,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: nameController,
                  hintText: 'Name',
                  icon: Icons.account_circle_outlined,
                  validator: (value) => Validations.emtyValidation(value),
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  validator: (value) => Validations.emailValidation(value),
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LogoutDialog();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log Out',
                        style: AppText.mediumdark,
                      ),
                      Icon(
                        Icons.logout,
                        color: AppColor.customColorsList[2],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadProfile() async {
    final userId = SharedPrefModel.instance.getData('userId');
    final userData = await DatabaseHelper().getUserById(userId);

    if (userData != null) {
      nameController.text = userData['username'] ?? '';
      emailController.text = userData['email'] ?? '';

      if (userData['profileImage'] != null) {
        _profileImageNotifier.value = File(userData['profileImage']);
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImageNotifier.value = File(pickedFile.path);
      });

      final email = emailController.text;
      if (email.isNotEmpty) {
        await DatabaseHelper().updateProfileImage(email, pickedFile.path);
        // ignore: use_build_context_synchronously
        CustomSnackBar.showSnackBar(context, 'Photo Updated');
      }
    }
  }
}
