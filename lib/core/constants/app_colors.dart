import 'package:flutter/material.dart';

/// RescuePang 앱의 색상 팔레트
/// 피그마 디자인 시스템을 기반으로 정의된 색상들
class AppColors {
  // Primary Colors (주요 색상)
  /// 메인 브랜드 색상 - 버튼, 강조 요소 등에 사용
  static const Color primary = Color(0xFF1D4ED8);

  /// 액센트 색상 - 경고, 알림 등에 사용
  static const Color accent = Color(0xFFFF7A00);

  // Background Colors (배경 색상)
  /// 메인 배경 색상
  static const Color background = Color(0xFFF9FAFB);

  /// 흰색 배경
  static const Color white = Color(0xFFFFFFFF);

  // Text Colors (텍스트 색상)
  /// 주요 텍스트 색상
  static const Color textPrimary = Color(0xFF374151);

  /// 보조 텍스트 색상 (플레이스홀더, 설명 등)
  static const Color textSecondary = Color(0xFF999999);

  /// 흰색 텍스트
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border Colors (테두리 색상)
  /// 기본 테두리 색상
  static const Color border = Color(0xFFE5E7EB);

  // Legacy Colors (기존 호환성을 위한 색상들)
  /// 로고 그라데이션 시작 색상
  static const Color logoGradientStart = Color(0xFF1D4ED8);

  /// 로고 그라데이션 끝 색상
  static const Color logoGradientEnd = Color(0xFF0F2972);

  /// 입력 필드 배경 색상
  static const Color inputBackground = Color(0xFFFFFFFF);

  /// 입력 필드 테두리 색상
  static const Color inputBorder = Color(0xFFE5E7EB);

  /// 주요 버튼 색상 (기존 호환성)
  static const Color primaryButton = Color(0xFFFF7A00);

  /// 입고 작업 아이콘 색상
  static const Color inboundIcon = Color(0xFF1D4ED8);

  /// 출고 작업 아이콘 색상
  static const Color outboundIcon = Color(0xFFFF7A00);
}
