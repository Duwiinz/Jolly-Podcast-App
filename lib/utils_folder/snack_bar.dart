// pop up flash
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';

customSnackBar(
  String? message,
  context,
  int? timeInSeconds, {
  Color? colorPassed,
}) {
  String msg = "";
  if (message!.contains("Exception: ")) {
    msg = message.split("Exception: ")[1];
  } else {
    msg = message;
  }

  if (msg == "Unauthorized") {
    msg = "Operation failed, try again...";
  }
  showFlash<bool>(
    barrierDismissible: true,
    duration: Duration(seconds: timeInSeconds ?? 5),
    builder: (context, controller) => FlashBar(
      backgroundColor: colorPassed ?? AppColors.color3,
      // backgroundColor: AppColors.color1,
      controller: controller,
      forwardAnimationCurve: Curves.easeInCirc,
      reverseAnimationCurve: Curves.bounceIn,
      position: FlashPosition.top,
      indicatorColor: AppColors.color4,
      // indicatorColor: AppColors.color2,
      icon: Icon(
        Icons.tips_and_updates_outlined,
        color: colorPassed != null ? AppColors.color3 : AppColors.color5,
      ),
      // title: Text(state.message),
      content: Text(
        msg,
        style: TextStyle(
          fontSize: 13.sp,
          color: colorPassed != null ? AppColors.color2 : AppColors.color8,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    context: context,
  );
}

// toast SnackBar
toastSnackBar(String? message, context) {
  String msg = "";
  if (message!.contains("Exception: ")) {
    msg = message.split("Exception: ")[1];
  } else {
    msg = message;
  }
  if (msg == "Unauthorized") {
    msg = "Operation failed, try again...";
  }
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
