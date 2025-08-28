import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siapngabdi/core/theme/colors.dart';

class AppTextStyles {
  /// Heading Utama
  static final heading = GoogleFonts.mulish(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    letterSpacing: -0.5,
  );

  /// Subheading / Section Title
  static final subheading = GoogleFonts.mulish(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
    letterSpacing: -0.2,
  );

  /// Body Text Default
  static final body = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.subtext,
    height: 1.6,
    letterSpacing: 0.2,
  );

  /// Bold Body / Section Emphasis
  static final bodyBold = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  /// Caption Kecil / Deskripsi / Metadata
  static final caption = GoogleFonts.mulish(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.subtext,
  );

  /// Tombol Putih di latar utama
  static final button = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  /// Tombol Outline (Text Color: Primary)
  static final buttonOutlined = GoogleFonts.mulish(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    letterSpacing: 0.5,
  );

  /// Headline Dashboard atau Hero Title
  static final hero = GoogleFonts.mulish(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );
}
