import 'package:json_annotation/json_annotation.dart';
part 'sanctions.g.dart';

@JsonSerializable(explicitToJson: true)
class Sanctions {
  final String idJugement;
  final String matriculation;
  //List<Sanction> sanctions = [];

  const Sanctions({required this.matriculation, required this.idJugement,/*required this.sanctions*/});

  Map<String, dynamic> toJson() => _$SanctionsToJson(this);

  factory Sanctions.fromJson(Map<String, dynamic> json) => _$SanctionsFromJson(json);
}