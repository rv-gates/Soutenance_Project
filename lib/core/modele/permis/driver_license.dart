import 'package:json_annotation/json_annotation.dart';
import 'package:soutenance_app/shared/enums/driver_license_category.dart';
import 'package:soutenance_app/shared/enums/driver_license_type.dart';

part 'driver_license.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverLicense {
  final DriverLicenseType type;
  final List<DriverLicenseCategory> categories;

  const DriverLicense({
    required this.type,
    required this.categories,
  });

  Map<String, dynamic> toJson() => _$DriverLicenseToJson(this);

  factory DriverLicense.fromJson(Map<String, dynamic> json) =>
      _$DriverLicenseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DriverLicenseCreated extends DriverLicense{
   final String id;

  const DriverLicenseCreated({
     required this.id,
    required super.type,
    required super.categories,
  });

  Map<String, dynamic> toJson() => _$DriverLicenseCreatedToJson(this);

  factory DriverLicenseCreated.fromJson(Map<String, dynamic> json) =>
      _$DriverLicenseCreatedFromJson(json);
}
