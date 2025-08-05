import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../presentation/pages/login_screen.dart';
import '../../presentation/pages/basic_screen.dart';
import '../../presentation/pages/mission_briefing_screen.dart';
import '../../presentation/pages/item_confirmation_screen.dart';

part 'app_router.gr.dart';

/// RescuePang 앱의 라우터 설정
/// AutoRoute를 사용하여 타입 안전한 네비게이션 제공
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    // 로그인 페이지 (초기 화면)
    AutoRoute(path: '/', page: LoginRoute.page, initial: true),

    AutoRoute(path: '/req', page: BasicRoute.page),
    AutoRoute(path: '/req/:reqType', page: BasicRoute.page),

    // Mission Briefing Screen (진열 물품 리스트 화면)
    AutoRoute(path: '/mission-briefing', page: MissionBriefingRoute.page),

    // Item Confirmation Screen (물품 확인 화면)
    AutoRoute(path: '/item-confirmation', page: ItemConfirmationRoute.page),
  ];
}
