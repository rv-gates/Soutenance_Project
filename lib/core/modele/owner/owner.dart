import 'package:json_annotation/json_annotation.dart';
import 'package:soutenance_app/shared/enums/genders.dart';

part 'owner.g.dart';

@JsonSerializable(explicitToJson: true)
class Owner {
  final String lastName, firstName;
  final String phoneNumber;
  final String civility;
  final Genders gender;

  const Owner({
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required this.civility,
    required this.gender,
  });

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class OwnerCreated extends Owner {
  final String id;

  const OwnerCreated(
      {required this.id,
      required super.lastName,
      required super.firstName,
      required super.phoneNumber,
      required super.civility,
      required super.gender});

  @override
  Map<String, dynamic> toJson() => _$OwnerCreatedToJson(this);

  factory OwnerCreated.fromJson(Map<String, dynamic> json) =>
      _$OwnerCreatedFromJson(json);
}
