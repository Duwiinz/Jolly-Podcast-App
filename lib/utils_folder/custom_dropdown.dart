import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';
import 'package:jolly_podcast/utils_folder/text_style.dart';

class CustomDropdown extends StatefulWidget {
  final String? aboveHaeader;
  final double? containerHeight;
  final String? initialValue;
  final String? hintText;
  final List<String> dropdownList;
  final TextEditingController theControllerPassed;
  final Function(String? value)? onChange;
  const CustomDropdown({
    super.key,
    this.aboveHaeader,
    this.containerHeight,
    required this.initialValue,
    this.hintText,
    required this.dropdownList,
    required this.theControllerPassed,
    this.onChange,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String initialValue = "";

  @override
  void initState() {
    initialValue = widget.initialValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.aboveHaeader != null)
          Column(
            children: [
              Text(
                widget.aboveHaeader ?? "",
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

        SizedBox(
          height: widget.containerHeight ?? 48,
          child: DropdownButtonFormField<String>(
            initialValue: initialValue,
            style: customTextStyle(
              context,
              16,
              AppColors.color31,
              FontWeight.w400,
              null,
            ),
            dropdownColor: AppColors.color2,
            isDense: true,
            isExpanded: true, // Key property to handle text overflow
            // decoration: const InputDecoration.collapsed(
            //   hintText: '',
            // ), // to hide the underline
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                // horizontal: 12.w,
                vertical: 10.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.color16),
                borderRadius: BorderRadius.circular(3.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.color16),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            icon: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            hint: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                widget.hintText ?? "",
                style: customTextStyle(
                  context,
                  16,
                  AppColors.color6,
                  FontWeight.w400,
                  0,
                ),
              ),
            ),
            onChanged: (String? newValue) {
              setState(() {
                initialValue = newValue!;
                widget.theControllerPassed.text = newValue;
                if (widget.onChange != null) {
                  widget.onChange!(newValue);
                }
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
            items: widget.dropdownList.map<DropdownMenuItem<String>>((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    value,
                    style: customTextStyle(
                      context,
                      16,
                      AppColors.color29,
                      FontWeight.w400,
                      1.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
