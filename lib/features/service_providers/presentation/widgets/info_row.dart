import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rlink_test/src/themes/app_colors.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
              text,
              style: TextStyle(fontSize: 12.sp,color: AppColors.black)
          ),
        ),
      ],
    );
  }
}