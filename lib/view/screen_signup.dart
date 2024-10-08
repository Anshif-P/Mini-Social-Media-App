// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mini_social_media_app/network/local_data_base/local_database.dart';
import 'package:mini_social_media_app/network/shared_preferences/shared_pref_model.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/util/snack_bar/snack_bar.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/view/screen_login.dart';
import 'package:mini_social_media_app/view/screen_parent.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/divider_widget.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ScreenSignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  bool loadingCheck = false;
  ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/Frame 2 (1).png'))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign Up',
                    style: AppText.largeDark,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create a new account',
                    style: AppText.smallLight,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: userNameController,
                    hintText: 'Username',
                    icon: Icons.person_outline_sharp,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Email',
                    icon: Icons.mail_outline_rounded,
                    validator: (value) => Validations.emailValidation(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    textVisibility: true,
                    controller: passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_open_rounded,
                    validator: (value) => Validations.isPassword(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    textVisibility: true,
                    controller: conPasswordController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_open_rounded,
                    validator: (value) => Validations.conformPasswordValidation(
                        value, passwordController.text),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(
                    colorCheck: true,
                    onpressFunction: () => signUpFnc(
                        context,
                        emailController.text,
                        userNameController.text,
                        passwordController.text),
                    text: 'Sing Up',
                    borderCheck: false,
                    loadingCheck: loadingCheck,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DividerWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    loadingCheck: false,
                    colorCheck: false,
                    onpressFunction: () => Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => ScreenLogIn())),
                    text: 'Sing in',
                    borderCheck: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpFnc(
      BuildContext context, String email, String name, String password) async {
    loadingCheck = true;
    if (signUpFormKey.currentState?.validate() ?? false) {
      DatabaseHelper dbHelper = DatabaseHelper();
      int? result = await dbHelper.registerUser(name, email, password, null);

      if (result != null) {
        SharedPrefModel.instance.insertData('userId', result);

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ScreenParentNavigation(
                  userData: {
                    'id': result,
                    'username': name,
                    'email': email,
                    'password': password,
                    'profileImage': '',
                  },
                )));
      } else {
        CustomSnackBar.showSnackBar(
            context, 'User already exists or registration failed');
      }
    }

    loadingCheck = false;
  }
}
