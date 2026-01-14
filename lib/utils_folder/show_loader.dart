import 'package:flutter/material.dart';
import 'package:jolly_podcast/utils_folder/app_colors.dart';

void showCustomLoader(context) {
  showDialog(
    context: context,
    barrierColor: AppColors.color3.withOpacity(0),
    barrierDismissible: false,
    builder: (context) {
      // PopScope added to showCustomLoader to avoid android back button removing the AlertDialog
      return PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.color3.withOpacity(0),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/loaderIcon.gif",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
