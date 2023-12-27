import 'package:json_annotation/json_annotation.dart';
part 'sanction.g.dart';

@JsonSerializable(explicitToJson: true)

class Sanction{
  final String sanction;

  const Sanction({
    required this.sanction,
  });

  Map<String, dynamic> toJson() => _$SanctionToJson(this);

  factory Sanction.fromJson(Map<String, dynamic> json) => _$SanctionFromJson(json);
}


@JsonSerializable(explicitToJson: true)
class SanctionCreated extends Sanction {
  final String id;
  const SanctionCreated({
    required this.id,
    required super.sanction,
  });

  @override
  Map<String, dynamic> toJson() => _$SanctionCreatedToJson(this);

  factory SanctionCreated.fromJson(Map<String, dynamic> json) =>
      _$SanctionCreatedFromJson(json);
}