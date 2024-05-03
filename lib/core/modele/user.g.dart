// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      matricule: json['matricule'] as String,
      role: $enumDecode(_$RoleUserEnumMap, json['role']),
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'matricule': instance.matricule,
      'role': _$RoleUserEnumMap[instance.role]!,
      'phoneNumber': instance.phoneNumber,
    };

const _$RoleUserEnumMap = {
  RoleUser.agent: 'agent',
  RoleUser.administrateur: 'administrateur',
};

UserCreated _$UserCreatedFromJson(Map<String, dynamic> json) => UserCreated(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      matricule: json['matricule'] as String,
      role: $enumDecode(_$RoleUserEnumMap, json['role']),
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserCreatedToJson(UserCreated instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'matricule': instance.matricule,
      'role': _$RoleUserEnumMap[instance.role]!,
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
    };
