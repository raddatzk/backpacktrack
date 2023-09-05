// import 'package:backpackcheck/ui/project/project_screen.dart';
// import 'package:backpackcheck/ui/setup/setup_screen.dart';
// import 'package:backpackcheck/ui/storage/storage_screen.dart';
// import 'package:backpackcheck/ui/utils/preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:go_router/go_router.dart';
//
// part 'router.freezed.dart';
//
// part 'router.g.dart';
//
// bool _startup = true;
// GlobalKey _storageScreenKey = GlobalKey();
// GlobalKey _projectScreenKey = GlobalKey();
//
// @TypedGoRoute<SetupRoute>(path: '/setup')
// class SetupRoute extends GoRouteData {
//   const SetupRoute();
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) => SetupScreen();
// }
//
// @TypedGoRoute<StorageRoute>(
//   path: '/storage',
//   routes: [
//     TypedGoRoute<CategoryRoute>(
//       path: 'categories/:categoryId',
//     ),
//     TypedGoRoute<NewCategoryRoute>(
//       path: 'categories/new',
//     ),
//   ],
// )
// class StorageRoute extends GoRouteData {
//   const StorageRoute();
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<StorageNavigator>().open();
//     return StorageScreen();
//   }
// }
//
// class CategoryRoute extends GoRouteData {
//   final String categoryId;
//
//   const CategoryRoute({
//     required this.categoryId,
//   });
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<StorageNavigator>().selectCategory(categoryId);
//     return StorageScreen();
//   }
// }
//
// class NewCategoryRoute extends GoRouteData {
//   const NewCategoryRoute();
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<StorageNavigator>().addCategory();
//     return StorageScreen();
//   }
// }
//
// @TypedGoRoute<ProjectRoute>(
//   path: '/projects/:projectId',
//   routes: [
//     TypedGoRoute<ProjectCategoryRoute>(
//       path: 'categories/:categoryId',
//     ),
//   ],
// )
// class ProjectRoute extends GoRouteData {
//   final String projectId;
//
//   const ProjectRoute({
//     required this.projectId,
//   });
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<ProjectNavigator>().open(projectId);
//     return ProjectScreen(title: "TBD", project: projectId);
//   }
// }
//
// class ProjectCategoryRoute extends GoRouteData {
//   final String projectId;
//   final String categoryId;
//
//   const ProjectCategoryRoute({
//     required this.projectId,
//     required this.categoryId,
//   });
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<ProjectNavigator>().selectCategory(projectId, categoryId);
//     return ProjectScreen(title: "TBD", project: projectId, category: categoryId);
//   }
// }
//
// class ProjectSettingsRoute extends GoRouteData {
//   final String projectId;
//
//   const ProjectSettingsRoute({
//     required this.projectId,
//   });
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     context.read<ProjectNavigator>().settings(projectId);
//     return ProjectScreen(title: "TBD", project: projectId);
//   }
// }
//
// final router = GoRouter(
//   initialLocation: '/storage',
//   routes: $appRoutes,
//   redirect: (context, state) {
//     if (Preferences.isSetupCompleted()) {
//       if (_startup) {
//         _startup = false;
//         return Preferences.getLastPosition();
//       } else {
//         return null;
//       }
//     } else {
//       return "/setup";
//     }
//   },
// );
//
// @freezed
// class StorageNavigatorState with _$StorageNavigatorState {
//   const factory StorageNavigatorState({
//     required NavigatorTriggerType type,
//     String? categoryId,
//   }) = _StorageNavigatorState;
// }
//
// @freezed
// class ProjectNavigatorState with _$ProjectNavigatorState {
//   const factory ProjectNavigatorState({
//     required NavigatorTriggerType type,
//     required String? projectId,
//     required String? categoryId,
//   }) = _ProjectNavigatorState;
// }
//
// enum NavigatorTriggerType {
//   internal,
//   external,
// }
//
// class StorageNavigator extends Cubit<StorageNavigatorState> {
//   StorageNavigator() : super(const StorageNavigatorState(type: NavigatorTriggerType.external, categoryId: null));
//
//   void open() => emit(const StorageNavigatorState(type: NavigatorTriggerType.external, categoryId: null));
//
//   void selectCategory(String categoryId) => emit(StorageNavigatorState(type: NavigatorTriggerType.internal, categoryId: categoryId));
//
//   void addCategory() => emit(const StorageNavigatorState(type: NavigatorTriggerType.internal, categoryId: null));
// }
//
// class ProjectNavigator extends Cubit<ProjectNavigatorState> {
//   ProjectNavigator() : super(const ProjectNavigatorState(type: NavigatorTriggerType.external, projectId: null, categoryId: null));
//
//   void open(String projectId) => emit(ProjectNavigatorState(type: NavigatorTriggerType.external, projectId: projectId, categoryId: null));
//
//   void selectCategory(String projectId, String categoryId) => emit(ProjectNavigatorState(type: NavigatorTriggerType.internal, projectId: projectId, categoryId: categoryId));
//
//   void settings(String projectId) => emit(ProjectNavigatorState(type: NavigatorTriggerType.internal, projectId: projectId, categoryId: null));
// }
