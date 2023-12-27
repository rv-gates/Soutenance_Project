// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      civility: json['civility'] as String,
      email: json['email'] as String,
      driverLicenseId: json['driverLicenseId'] as String,
      lastname: json['lastname'] as String,
      firstname: json['firstname'] as String,
      profession: json['profession'] as String,
      telephone: json['telephone'] as String,
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'civility': instance.civility,
      'driverLicenseId': instance.driverLicenseId,
      'email': instance.email,
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'profession': instance.profession,
      'telephone': instance.telephone,
    };

DriverCreated _$DriverCreatedFromJson(Map<String, dynamic> json) =>
    DriverCreated(
      id: json['id'] as String,
      civility: json['civility'] as String,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      profession: json['profession'] as String,
      telephone: json['telephone'] as String,
      driverLicenseId: json['driverLicenseId'] as String,
    );

Map<String, dynamic> _$DriverCreatedToJson(DriverCreated instance) =>
    <String, dynamic>{
      'civility': instance.civility,
      'driverLicenseId': instance.driverLicenseId,
      'email': instance.email,
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'profession': instance.profession,
      'telephone': instance.telephone,
      'id': instance.id,
    };
