import 'package:flutter/material.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';

import '../theme/app_colors.dart';
import '../theme/app_textstyle.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.backgroundColor = AppColors.teal,
    required this.text,
    required this.onPressed,
    this.height = 40,
    this.width,
    this.apistate = APISTATE.idle,
  });

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final double? width;
  final double height;
  final APISTATE apistate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: apistate == APISTATE.loading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AppTextStyle.title.medium.white,
              ),
      ),
    );
  }
}
