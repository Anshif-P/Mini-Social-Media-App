import 'package:flutter/material.dart';
import 'package:mini_social_media_app/util/constance/colors.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/util/validation/form_validation.dart';
import 'package:mini_social_media_app/widgets/comman/buttom_widget.dart';
import 'package:mini_social_media_app/widgets/comman/show_dialog.dart';
import 'package:mini_social_media_app/widgets/comman/text_feild_widget.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            const SizedBox(height: 15),
            ButtonWidget(
              onpressFunction: () {},
              text: 'Update Photo',
              colorCheck: true,
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: emailController,
              hintText: 'Name',
              icon: Icons.account_circle_outlined,
              validator: (value) => Validations.emailValidation(value),
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
            const SizedBox(height: 40),
            Container(
              decoration: const BoxDecoration(),
              child: InkWell(
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
