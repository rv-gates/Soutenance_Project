// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      mark: json['mark'] as String,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'mark': instance.mark,
    };

VehicleCreated _$VehicleCreatedFromJson(Map<String, dynamic> json) =>
    VehicleCreated(
      id: json['id'] as String,
      mark: json['mark'] as String,
      vehicleDocumentId: json['vehicleDocumentId'] as String,
    );

Map<String, dynamic> _$VehicleCreatedToJson(VehicleCreated instance) =>
    <String, dynamic>{
      'mark': instance.mark,
      'id': instance.id,
      'vehicleDocumentId': instance.vehicleDocumentId,
    };
