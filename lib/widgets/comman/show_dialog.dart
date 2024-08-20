import 'package:flutter/material.dart';
import 'package:mini_social_media_app/util/constance/colors.dart';
import 'package:mini_social_media_app/view/screen_login.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Sign Out ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Do you want to sign out',
        style: TextStyle(color: Color(0xFF6D6D6D)),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ScreenLogIn()));
          },
          child: const Text(
            'Sign out',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }
}
