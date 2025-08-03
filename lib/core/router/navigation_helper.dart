import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_router.dart';

/// 네비게이션 헬퍼 클래스
/// 페이지 간 이동을 위한 편의 메서드들 제공
class NavigationHelper {
  /// 로그인 페이지로 이동
  static void navigateToLogin(BuildContext context) {
    context.router.push(const LoginRoute());
  }

  /// Basic Screen으로 이동
  static void navigateToBasicScreen(BuildContext context) {
    context.router.push(const BasicRoute());
  }

  /// Basic Screen으로 이동 (이전 페이지 교체)
  static void replaceWithBasicScreen(BuildContext context) {
    context.router.replace(const BasicRoute());
  }

  /// 이전 페이지로 돌아가기
  static void goBack(BuildContext context) {
    context.router.pop();
  }

  /// 홈으로 돌아가기 (로그인 페이지)
  static void goHome(BuildContext context) {
    context.router.replaceAll([const LoginRoute()]);
  }

  /// 현재 라우트 이름 가져오기
  static String getCurrentRouteName(BuildContext context) {
    return context.router.current.name;
  }

  /// 특정 라우트에 있는지 확인
  static bool isOnRoute(BuildContext context, String routeName) {
    return context.router.current.name == routeName;
  }
}
