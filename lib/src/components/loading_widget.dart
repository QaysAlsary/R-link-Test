import 'package:flutter/material.dart';
import 'package:rlink_test/src/themes/app_colors.dart';


class LoadingWidget extends StatelessWidget {
  final bool isLoading;

  final Widget child;

  const LoadingWidget({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
        : child;
  }
}
