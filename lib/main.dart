import 'package:flutter/material.dart';
import 'package:mini_social_media_app/network/shared_preferences/shared_pref_model.dart';

import 'package:mini_social_media_app/view/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefModel.instance.initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}
