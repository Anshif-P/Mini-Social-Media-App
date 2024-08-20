import 'package:flutter/material.dart';
import 'package:mini_social_media_app/view/screen_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenLogin(),
    );
  }
}
