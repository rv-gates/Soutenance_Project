// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDocument _$VehicleDocumentFromJson(Map<String, dynamic> json) =>
    VehicleDocument(
      licensePlate: json['licensePlate'] as String,
      serialNumber: json['serialNumber'] as String,
      allowedWeight: json['allowedWeight'] as String,
      administrativePower: json['administrativePower'] as String,
      vehicleDocumentType: $enumDecode(
          _$VehicleDocumentTypeEnumMap, json['vehicleDocumentType']),
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$VehicleDocumentToJson(VehicleDocument instance) =>
    <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'ownerId': instance.ownerId,
      'serialNumber': instance.serialNumber,
      'allowedWeight': instance.allowedWeight,
      'administrativePower': instance.administrativePower,
      'vehicleDocumentType':
          _$VehicleDocumentTypeEnumMap[instance.vehicleDocumentType]!,
    };

const _$VehicleDocumentTypeEnumMap = {
  VehicleDocumentType.temporary: 'temporary',
  VehicleDocumentType.definitive: 'definitive',
};

VehicleDocumentCreated _$VehicleDocumentCreatedFromJson(
        Map<String, dynamic> json) =>
    VehicleDocumentCreated(
      id: json['id'] as String,
      licensePlate: json['licensePlate'] as String,
      serialNumber: json['serialNumber'] as String,
      allowedWeight: json['allowedWeight'] as String,
      administrativePower: json['administrativePower'] as String,
      vehicleDocumentType: $enumDecode(
          _$VehicleDocumentTypeEnumMap, json['vehicleDocumentType']),
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$VehicleDocumentCreatedToJson(
        VehicleDocumentCreated instance) =>
    <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'ownerId': instance.ownerId,
      'serialNumber': instance.serialNumber,
      'allowedWeight': instance.allowedWeight,
      'administrativePower': instance.administrativePower,
      'vehicleDocumentType':
          _$VehicleDocumentTypeEnumMap[instance.vehicleDocumentType]!,
      'id': instance.id,
    };
