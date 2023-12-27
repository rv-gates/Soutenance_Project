import 'package:json_annotation/json_annotation.dart';
import 'package:soutenance_app/shared/enums/vehicle_document_type.dart';

part 'vehicle_document.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleDocument {
  final String licensePlate, ownerId;
  final String serialNumber;
  final String allowedWeight;
  final String administrativePower;
  final VehicleDocumentType vehicleDocumentType;

  const VehicleDocument({
    required this.licensePlate,
    required this.serialNumber,
    required this.allowedWeight,
    required this.administrativePower,
    required this.vehicleDocumentType,
    required this.ownerId,
  });

  Map<String, dynamic> toJson() => _$VehicleDocumentToJson(this);

  factory VehicleDocument.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class VehicleDocumentCreated extends VehicleDocument {
  final String id;

  const VehicleDocumentCreated({
    required this.id,
    required super.licensePlate,
    required super.serialNumber,
    required super.allowedWeight,
    required super.administrativePower,
    required super.vehicleDocumentType,
    required super.ownerId,
  });

  @override
  Map<String, dynamic> toJson() => _$VehicleDocumentCreatedToJson(this);

  factory VehicleDocumentCreated.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentCreatedFromJson(json);
}
