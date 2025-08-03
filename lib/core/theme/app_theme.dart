import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// RescuePang 앱의 테마 시스템
/// 피그마 디자인 시스템을 기반으로 정의된 테마
class AppTheme {
  /// 기본 라이트 테마
  static ThemeData get lightTheme {
    return ThemeData(
      // 기본 색상 팔레트
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      // Material 3 사용
      useMaterial3: true,

      // 기본 폰트 패밀리
      fontFamily: 'Inter',

      // 앱바 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),

      // 텍스트 테마
      textTheme: const TextTheme(
        // 큰 제목 (24px, Bold)
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 29.0 / 24.0,
        ),

        // 중간 제목 (20px, Semi Bold)
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // 작은 제목 (18px, Semi Bold)
        headlineSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // 본문 텍스트 (16px, Regular)
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),

        // 작은 본문 텍스트 (14px, Regular)
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),

        // 보조 텍스트 (12px, Regular)
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),

      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // 입력 필드 테마
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),

      // 카드 테마
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  /// 다크 테마 (향후 지원 예정)
  static ThemeData get darkTheme {
    // TODO: 다크 테마 구현
    return lightTheme;
  }
}
