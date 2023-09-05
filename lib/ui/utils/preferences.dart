import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late final SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setUserId(String userId) async {
    return _preferences.setString("userId", userId);
  }

  static String getUserId() {
    return _preferences.getString("userId")!;
  }

  static Future<bool> setSetupCompleted(bool setupCompleted) async {
    return _preferences.setBool("setupCompleted", setupCompleted);
  }

  static bool isSetupCompleted() {
    return _preferences.getBool("setupCompleted") ?? false;
  }

  static Future<bool> setLastStorageUrl(String url) {
    return _preferences.setString("lastStorageUrl", url);
  }

  static String getLastStorageUrl() {
    return _preferences.getString("lastStorageUrl")!;
  }

  static Future<bool> setLastProjectsUrl(String url) {
    return _preferences.setString("lastProjectUrl", url);
  }

  static String getLastProjectsUrl() {
    return _preferences.getString("lastProjectUrl")!;
  }

  static Future<bool> goToProjects() async {
    return _preferences.setInt("rootLocation", RootNavigation.projects.index);
  }

  static Future<bool> goToStorage() async {
    return _preferences.setInt("rootLocation", RootNavigation.storage.index);
  }

  static RootNavigation getRootNavigation() {
    return RootNavigation.values[_preferences.getInt("rootLocation")!];
  }
}

enum RootNavigation {
  storage,
  projects,
}