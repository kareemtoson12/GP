import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whispertales/core/styles/customs_color.dart';

class AppTextStyles {
  static TextStyle font20SeconColor = GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: CustomsColros.secondColor));
  static TextStyle font22SeconColor = GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: CustomsColros.secondColor));
  static TextStyle font30SeconColor = GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: CustomsColros.secondColor));

  static TextStyle font20blackRegular = GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black));

  static TextStyle font18BlackBold = GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black));

  static TextStyle font20GoogleFont = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: CustomsColros.secondColor,
    ),
  );

  static TextStyle font20GoogleFontEWhite = GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}
