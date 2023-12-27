// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sanction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sanction _$SanctionFromJson(Map<String, dynamic> json) => Sanction(
      sanction: json['sanction'] as String,
    );

Map<String, dynamic> _$SanctionToJson(Sanction instance) => <String, dynamic>{
      'sanction': instance.sanction,
    };

SanctionCreated _$SanctionCreatedFromJson(Map<String, dynamic> json) =>
    SanctionCreated(
      id: json['id'] as String,
      sanction: json['sanction'] as String,
    );

Map<String, dynamic> _$SanctionCreatedToJson(SanctionCreated instance) =>
    <String, dynamic>{
      'sanction': instance.sanction,
      'id': instance.id,
    };
