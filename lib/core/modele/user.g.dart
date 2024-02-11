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
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'matricule': instance.matricule,
      'role': instance.role,
    };

UserCreated _$UserCreatedFromJson(Map<String, dynamic> json) => UserCreated(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      matricule: json['matricule'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserCreatedToJson(UserCreated instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'matricule': instance.matricule,
      'role': instance.role,
      'id': instance.id,
    };
