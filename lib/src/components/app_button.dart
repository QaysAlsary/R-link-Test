import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.isOutlined = false,
    this.isLoading = false,
  });

  const AppButton.outlined({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.isOutlined = true,
    this.isLoading = false,
  });

  final String title;
  final Color? textColor;
  final Color? bgColor;
  final void Function()? onPressed;
  final bool isOutlined;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(1),
          backgroundColor:
          MaterialStateProperty.all(isOutlined ? AppColors.white : bgColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                color: bgColor ?? AppColors.primary,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.r),
          child: isLoading
              ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: AppColors.white,
              ))
              : Text(
            title,
            style: textTheme.labelLarge!.copyWith(
              color: isOutlined
                  ? textColor ?? AppColors.primary
                  : textColor ?? AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
