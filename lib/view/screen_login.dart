import 'package:flutter/material.dart';
import 'package:mini_social_media_app/network/local_data_base/local_database.dart';
import 'package:mini_social_media_app/network/shared_preferences/shared_pref_model.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/util/snack_bar/snack_bar.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/view/screen_parent.dart';
import 'package:mini_social_media_app/view/screen_signup.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/divider_widget.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ScreenLogIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool loadingCheck = false;

  ScreenLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: loginFormKey,
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
                    'Welcome To BuzzSpace',
                    style: AppText.largeDark,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign in to Continue',
                    style: AppText.smallLight,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Email',
                    icon: Icons.account_circle_outlined,
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
                    icon: Icons.lock_open_outlined,
                    validator: (value) => Validations.isPassword(value),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget Password?',
                        style: AppText.smallDark,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          onChanged: (value) {}),
                      Text(
                        'Remeber me and keep me logged in',
                        style: AppText.smallGrey,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                    colorCheck: true,
                    onpressFunction: () => logInFnc(
                        context, emailController.text, passwordController.text),
                    text: 'Log in',
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
                            builder: (context) => ScreenSignUp())),
                    text: 'Sing Up',
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

  void logInFnc(BuildContext context, String email, String password) async {
    if (loginFormKey.currentState?.validate() ?? false) {
      if (await Permission.storage.request().isGranted) {
        final dbHelper = DatabaseHelper();
        final user = await dbHelper.loginUser(email, password);
        if (user != null) {
          SharedPrefModel.instance.insertData('userId', user['id']);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => ScreenParentNavigation(
                      userData: user,
                    )),
          );
        } else {
          // ignore: use_build_context_synchronously
          CustomSnackBar.showSnackBar(context, 'Invalid email or password');
        }
      } else {
        CustomSnackBar.showSnackBar(
            // ignore: use_build_context_synchronously
            context,
            'Please allow storage permission');
      }
    }
  }
}
