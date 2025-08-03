// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BasicRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasicScreen(),
      );
    },
    ItemConfirmationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ItemConfirmationScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MissionBriefingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MissionBriefingScreen(),
      );
    },
  };
}

/// generated route for
/// [BasicScreen]
class BasicRoute extends PageRouteInfo<void> {
  const BasicRoute({List<PageRouteInfo>? children})
      : super(
          BasicRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasicRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ItemConfirmationScreen]
class ItemConfirmationRoute extends PageRouteInfo<void> {
  const ItemConfirmationRoute({List<PageRouteInfo>? children})
      : super(
          ItemConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ItemConfirmationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MissionBriefingScreen]
class MissionBriefingRoute extends PageRouteInfo<void> {
  const MissionBriefingRoute({List<PageRouteInfo>? children})
      : super(
          MissionBriefingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MissionBriefingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
