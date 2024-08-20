import 'package:flutter/material.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/view/screen_signup.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/divider_widget.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';

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
                    validator: (value) => Validations.emtyValidation(value),
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

  logInFnc(BuildContext context, String mail, String password) async {}
}
