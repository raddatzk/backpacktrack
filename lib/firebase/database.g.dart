// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String,
      name: json['name'] as String,
      deviceIds:
          (json['deviceIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deviceIds': instance.deviceIds,
    };

_$_Storage _$$_StorageFromJson(Map<String, dynamic> json) => _$_Storage(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visitors: (json['visitors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_StorageToJson(_$_Storage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'categories': instance.categories,
      'visitors': instance.visitors,
    };

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      visitors: (json['visitors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'category': instance.category,
      'visitors': instance.visitors,
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as String,
      name: json['name'] as String,
      visitors: (json['visitors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'visitors': instance.visitors,
    };

_$_Project _$$_ProjectFromJson(Map<String, dynamic> json) => _$_Project(
      id: json['id'] as String,
      name: json['name'] as String,
      routeName: json['routeName'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ProjectItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visitors: (json['visitors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      luggage: (json['luggage'] as List<dynamic>?)
              ?.map((e) => Luggage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'routeName': instance.routeName,
      'items': instance.items,
      'visitors': instance.visitors,
      'luggage': instance.luggage,
    };

_$_ProjectItem _$$_ProjectItemFromJson(Map<String, dynamic> json) =>
    _$_ProjectItem(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      checked: json['checked'] as bool,
      luggage: (json['luggage'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_ProjectItemToJson(_$_ProjectItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'checked': instance.checked,
      'luggage': instance.luggage,
    };

_$_Luggage _$$_LuggageFromJson(Map<String, dynamic> json) => _$_Luggage(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_LuggageToJson(_$_Luggage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
