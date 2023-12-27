import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable(explicitToJson: true)
class Driver {
  final String civility, driverLicenseId;
  final String email;
  final String lastname;
  final String firstname;
  final String profession;
  final String telephone;

  const Driver({
    required this.civility,
    required this.email,
    required this.driverLicenseId,
    required this.lastname,
    required this.firstname,
    required this.profession,
    required this.telephone,
  });

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DriverCreated extends Driver {
  final String id;

  const DriverCreated({
    required this.id,
    required super.civility,
    required super.email,
    required super.firstname,
    required super.lastname,
    required super.profession,
    required super.telephone,
    required super.driverLicenseId,
  });

  @override
  Map<String, dynamic> toJson() => _$DriverCreatedToJson(this);

  factory DriverCreated.fromJson(Map<String, dynamic> json) =>
      _$DriverCreatedFromJson(json);
}
