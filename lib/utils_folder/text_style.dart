import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

customTextStyle(
  BuildContext context,
  int fontSize,
  Color? color,
  FontWeight fontWeight,
  height,
) =>
    // TextStyle(
    //   fontSize: fontSize,
    //   color: color,
    //   fontWeight: FontWeight.w400,
    //   // height: height, // passed but not used
    // ).copyWith(color: );
    GoogleFonts.nunito(
      textStyle: TextStyle(
        fontSize: double.tryParse(fontSize.sp.toString()),
        color:
            color ??
            Theme.of(context).primaryColor, //color, // passed but not used
        fontWeight: FontWeight.w700,
      ),
    );
