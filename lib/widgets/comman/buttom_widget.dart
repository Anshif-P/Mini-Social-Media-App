import 'package:flutter/material.dart';
import 'package:mini_social_media_app/util/constance/colors.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';

class ButtonWidget extends StatelessWidget {
  final bool paymentButtonCheck;
  final String text;
  final bool colorCheck;
  final bool borderCheck;
  final VoidCallback onpressFunction;
  final bool loadingCheck;
  final bool reviewButtonCheck;
  const ButtonWidget(
      {super.key,
      this.reviewButtonCheck = false,
      this.paymentButtonCheck = false,
      required this.onpressFunction,
      required this.text,
      required this.colorCheck,
      this.loadingCheck = false,
      this.borderCheck = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: reviewButtonCheck ? 35 : 48,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize:
                WidgetStateProperty.all(const Size.fromWidth(double.maxFinite)),
            elevation: WidgetStateProperty.all(0),
            side: borderCheck
                ? WidgetStateProperty.all<BorderSide>(const BorderSide(
                    color: Color(0xFFD1D1D1),
                    width: 1,
                  ))
                : null,
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
                colorCheck ? AppColor.primaryColor : Colors.white),
          ),
          onPressed: onpressFunction,
          child: loadingCheck
              ? Transform.scale(
                  scale: 0.5,
                  child: const CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.white,
                  ))
              : Text(
                  text,
                  style: borderCheck ? AppText.mediumdark : AppText.mediumLight,
                ),
        ));
  }
}
