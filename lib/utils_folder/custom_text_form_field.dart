import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String? aboveHaeader;
  final String? label;
  final TextStyle? labelStyle;
  final String? hintText;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  //final TextInputAction? textInputAction; // ✅ ADD
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  //final void Function(String)? onFieldSubmitted; // ✅ ADD
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? counterText;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadiusPassed;

  const CustomTextFormField({
    super.key,
    this.aboveHaeader,
    this.label,
    this.labelStyle,
    this.focusNode,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.keyboardType = TextInputType.text,
    //this.textInputAction, // ✅ ADD
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    //this.onFieldSubmitted, // ✅ ADD
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.counterText,
    this.maxLength,
    this.contentPadding,
    this.borderRadiusPassed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (aboveHaeader != null)
          Column(
            children: [
              Text(
                aboveHaeader ?? "",
                style: customTextStyle(
                  context,
                  16,
                  AppColors.color9,
                  FontWeight.w400,
                  null,
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        TextFormField(
          cursorHeight: 14.h,
          style: customTextStyle(
            context,
            16,
            AppColors.color31,
            FontWeight.w400,
            null,
          ),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          maxLines: maxLines,
          readOnly: readOnly,
          focusNode: focusNode,
          onTap: onTap,
          maxLength: maxLength,
          decoration: InputDecoration(
            //label: Text(label ?? ""),
            //labelStyle: labelStyle,
            counterText: counterText,
            hintText: hintText,
            hintStyle:
                hintStyle ??
                TextStyle(color: Colors.grey.shade500, fontSize: 14),

            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadiusPassed ?? 3.r,
              ), // Rounded corners
              borderSide: BorderSide(color: AppColors.color14),
            ),
            filled: true,
            fillColor: AppColors.color2,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Center(child: prefixIcon),
                    ),
                  )
                : null,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusPassed ?? 20.r),
              borderSide: BorderSide(color: AppColors.color14),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusPassed ?? 20.r),
              borderSide: BorderSide(color: AppColors.color14),
            ),
            contentPadding: contentPadding,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
