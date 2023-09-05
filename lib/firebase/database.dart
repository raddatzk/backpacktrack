import 'package:backpackcheck/firebase/authentication.dart';
import 'package:backpackcheck/ui/utils/preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'database.freezed.dart';

part 'database.g.dart';

Map<String, dynamic> parseFirebaseResponse(DataSnapshot snapshot) {
  Map<String, dynamic> map = {};
  for (final entry in (snapshot.value as Map).entries) {
    map[entry.key] = entry.value;
  }

  return map;
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required List<String> deviceIds,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User fromFirebase(DataSnapshot snapshot) => User.fromJson(parseFirebaseResponse(snapshot));
}

@freezed
class Storage with _$Storage {
  const factory Storage({
    required String id,
    @Default([]) List<Item> items,
    @Default([]) List<Category> categories,
    @Default([]) List<String> visitors,
  }) = _Storage;

  factory Storage.fromJson(Map<String, dynamic> json) => _$StorageFromJson(json);

  static Storage fromFirebase(DataSnapshot snapshot) => Storage.fromJson(parseFirebaseResponse(snapshot));
}

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required double amount,
    required Category category,
    @Default([]) List<String> visitors,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  factory Item.fromFirebase(DataSnapshot snapshot) => Item.fromJson(parseFirebaseResponse(snapshot));
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    @Default([]) List<String> visitors,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  factory Category.fromFirebase(DataSnapshot snapshot) => Category.fromJson(parseFirebaseResponse(snapshot));
}

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String name,
    required String routeName,
    @Default([]) List<ProjectItem> items,
    @Default([]) List<String> visitors,
    @Default([]) List<Luggage> luggage,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  factory Project.fromFirebase(DataSnapshot snapshot) => Project.fromJson(parseFirebaseResponse(snapshot));
}

@freezed
class ProjectItem with _$ProjectItem {
  const factory ProjectItem({
    required String id,
    required double amount,
    required bool checked,
    @Default({}) Map<String, double> luggage,
  }) = _ProjectItem;

  const ProjectItem._();

  factory ProjectItem.fromJson(Map<String, dynamic> json) => _$ProjectItemFromJson(json);

  factory ProjectItem.fromFirebase(DataSnapshot snapshot) => ProjectItem.fromJson(parseFirebaseResponse(snapshot));

  Future<Item> get parent async {
    var storage = await Database.getOrCreateStorage();
    return Database.getItem(storage.id, id);
  }
}

@freezed
class Luggage with _$Luggage {
  const factory Luggage({
    required String id,
    required String name,
  }) = _Luggage;

  factory Luggage.fromJson(Map<String, dynamic> json) => _$LuggageFromJson(json);

  factory Luggage.fromFirebase(DataSnapshot snapshot) => Luggage.fromJson(parseFirebaseResponse(snapshot));
}

class Database {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  static void listenOnCategories(void Function(List<String>) callback) async {
    var userId = Preferences.getUserId();
    var ref = _database.ref('storages/$userId/categories');
    ref.onValue.listen((event) {
      callback(event.snapshot.children.map((child) => Category.fromFirebase(child).id).toList());
    });
  }

  static void listenOnProjects(void Function(Map<String, List<String>>) callback) async {
    var userId = Preferences.getUserId();
    var ref = _database.ref('projects/$userId');
    ref.onValue.listen((event) async {
      Map<String, List<String>> map = {};
      var projects = event.snapshot.children.map((child) => Project.fromFirebase(child)).toList();
      for (var project in projects) {
        var id = project.id;
        var categories = await Future.wait(project.items.map((item) async => (await item.parent).category.id).toList());
        map[id] = categories;
      }
    });
  }

  static Future<Item> getItem(String storage, String itemId) async {
    var userId = Preferences.getUserId();
    var snapshot = await _database.ref('storages/$userId/items/$itemId').get();
    return Item.fromFirebase(snapshot);
  }

  static Future<User> getCurrentUser() async {
    var userId = Preferences.getUserId();
    var snapshot = await _database.ref('users/$userId').get();
    return User.fromFirebase(snapshot);
  }

  static Future<User> createUser(String username) async {
    var deviceId = const Uuid().v4();
    var ref = _database.ref('users').push();
    var user = User(
      id: ref.key!,
      name: username,
      deviceIds: [deviceId],
    );
    ref.set(user.toJson());
    return user;
  }

  static Future<void> addThisDeviceToCurrentUser() async {
    var credentials = await Authentication.loginAnonymously();
    var userId = Preferences.getUserId();
    var ref = _database.ref('users/$userId/deviceIds').push();
    ref.set(credentials.user!.uid);
  }

  static Future<bool> userStorageExists(String userId) async {
    var snapshot = await _database.ref('storages/$userId').get();
    return snapshot.exists;
  }

  static Future<Storage> getOrCreateStorage() async {
    var userId = Preferences.getUserId();
    var ref = _database.ref('storages/$userId');
    if (await userStorageExists(userId)) {
      return Storage.fromFirebase(await ref.get());
    } else {
      var storage = Storage(id: ref.key!, items: [], categories: [], visitors: []);
      ref.set(storage.toJson());
      return storage;
    }
  }

  static Future<Category> createCategory(String categoryName) async {
    var userId = Preferences.getUserId();
    var ref = _database.ref('storages/$userId/categories').push();
    var category = Category(id: ref.key!, name: categoryName, visitors: []);
    ref.set(category.toJson()).then((_) => categoryAddedEvent.trigger(category.id));

    return category;
  }

  static Future<List<Category>> getCategories() async {
    var userId = Preferences.getUserId();
    var ref = await _database.ref('storages/$userId/categories').get();
    return ref.children.map((child) => Category.fromFirebase(child)).toList();
  }

  static Stream<List<Category>> watchCategories() {
    var userId = Preferences.getUserId();
    return _database.ref('storages/$userId/categories').onValue.map((event) => event.snapshot.children.map((snapshot) => Category.fromFirebase(snapshot)).toList());
  }

  static Stream<Category> watchAddedCategories() {
    var userId = Preferences.getUserId();
    return _database.ref('storages/$userId/categories').onChildAdded.map((event) => Category.fromFirebase(event.snapshot));
  }

  static Stream<Category> watchRemovedCategories() {
    var userId = Preferences.getUserId();
    return _database.ref('storages/$userId/categories').onChildRemoved.map((event) => Category.fromFirebase(event.snapshot));
  }
}

class CategoryAddedEvent with ChangeNotifier {
  late String categoryId;

  void trigger(String categoryId) {
    this.categoryId = categoryId;
    notifyListeners();
  }
}

final categoryAddedEvent = CategoryAddedEvent();
