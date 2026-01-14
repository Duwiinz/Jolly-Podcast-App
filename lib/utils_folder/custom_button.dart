import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/text_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color? textColor;
  final Color? containerColor;
  final int? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final String? imgUrl;
  final Function()? onClick;
  const CustomButton({
    super.key,
    required this.text,
    this.textColor,
    this.containerColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.imgUrl,
    this.onClick,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        height: 53.h,
        width: 343.w, // double.infinity,
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 28.r),
        ),
        child: Center(
          child: widget.imgUrl == null
              ? Text(
                  widget.text,
                  style: customTextStyle(
                    context,
                    widget.fontSize ?? 16,
                    widget.textColor ?? AppColors.color2,
                    widget.fontWeight ?? FontWeight.w500,
                    1.4,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(widget.imgUrl!, width: 20.w, height: 20.h),
                    SizedBox(width: 16.w),
                    Text(
                      widget.text,
                      style: customTextStyle(
                        context,
                        widget.fontSize ?? 18,
                        widget.textColor ?? AppColors.color2,
                        widget.fontWeight ?? FontWeight.w500,
                        1.4,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
