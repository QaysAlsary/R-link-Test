import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rlink_test/src/utils/widget_extension.dart';
import '../extensions/iterable_extension.dart';
import '../themes/app_colors.dart';
import '../themes/app_theme.dart';
import '../validation/base_validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.suffixIcon,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hint;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class TextFieldWithTitle extends StatelessWidget {
  const TextFieldWithTitle({
    Key? key,
    required this.title,
    required this.widget,
    this.optional = false,
  }) : super(key: key);
  final String title;
  final Widget widget;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textTheme.labelLarge,
            ),
            if (optional)
              Text(
                'optional',
                style: textTheme.bodyLarge!.copyWith(
                  color: AppColors.medium,
                ),
              ),
          ],
        ),
        widget,
      ].addSpaces(height: 8).toList(),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.prefix,
    this.hideText = false,
    this.onSubmit,
    this.width,
    this.onChanged,
    this.label,
    this.hintText,this.secure = false,
    this.validator,
    this.prefixConstraint,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.suffixIcon,
    this.initialValue,
  })  : assert(secure == false || suffixIcon == null),
        super(key: key);

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final Widget? prefix;
  bool hideText;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final double? width;
  final String? label;
  final bool secure;
  final BaseValidator? validator;
  final BoxConstraints? prefixConstraint;
  final TextAlign textAlign;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? suffixIcon;
  final String? initialValue;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        onFieldSubmitted: widget.onSubmit,
        controller: widget.controller,
        obscureText: widget.hideText,
        onChanged: widget.onChanged,
        textAlign: widget.textAlign,
        validator: widget.validator?.validator,
        inputFormatters: [
          ...?widget.inputFormatters,
          if (widget.keyboardType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.light)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.light)),


          counterText: '',
          hintText: widget.hintText,
          hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.dark),
          prefixIcon: widget.prefix,
          prefixIconConstraints: widget.prefixConstraint,
          labelText: widget.label,
          labelStyle: textTheme.bodyLarge?.copyWith(color: AppColors.dark),
          suffixIcon: widget.secure ? secureWidget : widget.suffixIcon,
        )).size(w: widget.width, h: 60.h);
  }

  Widget get secureWidget => IconButton(
      onPressed: () {
        setState(() {
          widget.hideText = !widget.hideText;
        });
      },
      icon: widget.hideText
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off));
}
