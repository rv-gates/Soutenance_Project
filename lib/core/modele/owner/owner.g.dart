// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      civility: json['civility'] as String,
      gender: $enumDecode(_$GendersEnumMap, json['gender']),
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'phoneNumber': instance.phoneNumber,
      'civility': instance.civility,
      'gender': _$GendersEnumMap[instance.gender]!,
    };

const _$GendersEnumMap = {
  Genders.male: 'male',
  Genders.female: 'female',
};

OwnerCreated _$OwnerCreatedFromJson(Map<String, dynamic> json) => OwnerCreated(
      id: json['id'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      civility: json['civility'] as String,
      gender: $enumDecode(_$GendersEnumMap, json['gender']),
    );

Map<String, dynamic> _$OwnerCreatedToJson(OwnerCreated instance) =>
    <String, dynamic>{
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'phoneNumber': instance.phoneNumber,
      'civility': instance.civility,
      'gender': _$GendersEnumMap[instance.gender]!,
      'id': instance.id,
    };
