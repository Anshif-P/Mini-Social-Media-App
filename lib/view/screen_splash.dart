import 'package:flutter/material.dart';
import 'package:mini_social_media_app/network/local_data_base/local_database.dart';
import 'package:mini_social_media_app/network/shared_preferences/shared_pref_model.dart';
import 'package:mini_social_media_app/util/constance/colors.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';
import 'package:mini_social_media_app/view/screen_parent.dart';
import 'package:mini_social_media_app/view/screen_signup.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    userLoginValidation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Frame 2 (1).png'))),
              ),
              Text(
                'BuzzSpace',
                style: AppText.largeDark,
              ),
            ],
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Transform.scale(
                scale: .9,
                child: const CircularProgressIndicator(
                    strokeWidth: 6, color: AppColor.grey),
              ),
            ),
          ],
        ))
      ]),
    );
  }

  userLoginValidation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    final userId = await SharedPrefModel.instance.getData('userId');

    if (userId != null) {
      final userData = await DatabaseHelper().getUserById(userId);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ScreenParentNavigation(
                userData: userData!,
              )));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenSignUp()));
    }
  }
}
