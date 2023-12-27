// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLicense _$DriverLicenseFromJson(Map<String, dynamic> json) =>
    DriverLicense(
      type: $enumDecode(_$DriverLicenseTypeEnumMap, json['type']),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => $enumDecode(_$DriverLicenseCategoryEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$DriverLicenseToJson(DriverLicense instance) =>
    <String, dynamic>{
      'type': _$DriverLicenseTypeEnumMap[instance.type]!,
      'categories': instance.categories
          .map((e) => _$DriverLicenseCategoryEnumMap[e]!)
          .toList(),
    };

const _$DriverLicenseTypeEnumMap = {
  DriverLicenseType.temporary: 'temporary',
  DriverLicenseType.definitive: 'definitive',
};

const _$DriverLicenseCategoryEnumMap = {
  DriverLicenseCategory.a1: 'a1',
  DriverLicenseCategory.a: 'a',
  DriverLicenseCategory.b: 'b',
  DriverLicenseCategory.c: 'c',
  DriverLicenseCategory.d: 'd',
  DriverLicenseCategory.e: 'e',
  DriverLicenseCategory.f: 'f',
  DriverLicenseCategory.g: 'g',
};

DriverLicenseCreated _$DriverLicenseCreatedFromJson(
        Map<String, dynamic> json) =>
    DriverLicenseCreated(
      id: json['id'] as String,
      type: $enumDecode(_$DriverLicenseTypeEnumMap, json['type']),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => $enumDecode(_$DriverLicenseCategoryEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$DriverLicenseCreatedToJson(
        DriverLicenseCreated instance) =>
    <String, dynamic>{
      'type': _$DriverLicenseTypeEnumMap[instance.type]!,
      'categories': instance.categories
          .map((e) => _$DriverLicenseCategoryEnumMap[e]!)
          .toList(),
      'id': instance.id,
    };
