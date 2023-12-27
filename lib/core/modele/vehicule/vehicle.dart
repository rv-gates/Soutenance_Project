import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable(explicitToJson: true)
class Vehicle {
  final String mark;

  const Vehicle({required this.mark});

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class VehicleCreated extends Vehicle {
  final String id, vehicleDocumentId;

  const VehicleCreated({
    required this.id,
    required super.mark,
    required this.vehicleDocumentId,
  });

  @override
  Map<String, dynamic> toJson() => _$VehicleCreatedToJson(this);

  factory VehicleCreated.fromJson(Map<String, dynamic> json) =>
      _$VehicleCreatedFromJson(json);
}
