import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static final heading = GoogleFonts.mulish(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final body = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0x202244CC),
    letterSpacing: 0.2,
  );

  static final button = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
