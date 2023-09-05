import 'package:backpackcheck/ui/utils/preferences.dart';
import 'package:backpackcheck/ui/widgets/category_tab.dart';
import 'package:backpackcheck/ui/widgets/new_category_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../setup/setup_screen.dart';
import '../storage/storage_screen.dart';

part 'router2.g.dart';

bool _startup = true;

@TypedGoRoute<SetupRoute>(path: '/setup')
class SetupRoute extends GoRouteData {
  const SetupRoute();

  void navigate(BuildContext context) => go(context);

  @override
  Widget build(BuildContext context, GoRouterState state) => SetupScreen();
}

@TypedShellRoute<StorageRoute>(
  routes: [
    TypedGoRoute<NewCategoryRoute>(
      path: '/storage/categories/new',
    ),
    TypedGoRoute<CategoryRoute>(
      path: '/storage/categories/:categoryId',
    ),
  ],
)
class StorageRoute extends ShellRouteData {
  const StorageRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => StorageScreen(child: navigator);
}

class CategoryRoute extends GoRouteData {
  final String categoryId;

  const CategoryRoute({
    required this.categoryId,
  });

  void navigate(BuildContext context) {
    Preferences.goToStorage();
    Preferences.setLastStorageUrl(location);
    go(context);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const StorageCategoryTab();
}

class NewCategoryRoute extends GoRouteData {
  const NewCategoryRoute();

  void navigate(BuildContext context) {
    Preferences.goToStorage();
    Preferences.setLastStorageUrl(location);
    go(context);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const NewCategoryTab();
}

final router = GoRouter(
  initialLocation: '/storage/categories/new',
  routes: $appRoutes,
  redirect: (context, state) {
    if (Preferences.isSetupCompleted()) {
      if (_startup) {
        _startup = false;
        switch (Preferences.getRootNavigation()) {
          case RootNavigation.storage:
            return Preferences.getLastStorageUrl();
          case RootNavigation.projects:
            return Preferences.getLastProjectsUrl();
        }
      } else {
        return null;
      }
    } else {
      return "/setup";
    }
  },
);
