// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router2.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $setupRoute,
      $storageRoute,
    ];

RouteBase get $setupRoute => GoRouteData.$route(
      path: '/setup',
      factory: $SetupRouteExtension._fromState,
    );

extension $SetupRouteExtension on SetupRoute {
  static SetupRoute _fromState(GoRouterState state) => const SetupRoute();

  String get location => GoRouteData.$location(
        '/setup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $storageRoute => ShellRouteData.$route(
      factory: $StorageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/storage/categories/new',
          factory: $NewCategoryRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/storage/categories/:categoryId',
          factory: $CategoryRouteExtension._fromState,
        ),
      ],
    );

extension $StorageRouteExtension on StorageRoute {
  static StorageRoute _fromState(GoRouterState state) => const StorageRoute();
}

extension $NewCategoryRouteExtension on NewCategoryRoute {
  static NewCategoryRoute _fromState(GoRouterState state) =>
      const NewCategoryRoute();

  String get location => GoRouteData.$location(
        '/storage/categories/new',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CategoryRouteExtension on CategoryRoute {
  static CategoryRoute _fromState(GoRouterState state) => CategoryRoute(
        categoryId: state.pathParameters['categoryId']!,
      );

  String get location => GoRouteData.$location(
        '/storage/categories/${Uri.encodeComponent(categoryId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
