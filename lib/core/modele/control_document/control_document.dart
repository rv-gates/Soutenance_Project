
import 'package:json_annotation/json_annotation.dart';

import '../sanction/sanction.dart';

part 'control_document.g.dart';

@JsonSerializable(explicitToJson: true)
class ControlDocument {
  final DateTime date;
  final Sanction sanction;


  const ControlDocument({
    required this.date,
    required this.sanction,
  });

  Map<String, dynamic> toJson() => _$ControlDocumentToJson(this);

  factory ControlDocument.fromJson(Map<String, dynamic> json) =>
      _$ControlDocumentFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ControlDocumentCreated extends ControlDocument {
  final String id;

  const ControlDocumentCreated({
    required this.id,
    required super.date,
    required super.sanction,

  });

  @override
  Map<String, dynamic> toJson() => _$ControlDocumentCreatedToJson(this);

  factory ControlDocumentCreated.fromJson(Map<String, dynamic> json) =>
      _$ControlDocumentCreatedFromJson(json);
}