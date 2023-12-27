// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sanctions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sanctions _$SanctionsFromJson(Map<String, dynamic> json) => Sanctions(
      matriculation: json['matriculation'] as String,
      idJugement: json['idJugement'] as String,
    );

Map<String, dynamic> _$SanctionsToJson(Sanctions instance) => <String, dynamic>{
      'idJugement': instance.idJugement,
      'matriculation': instance.matriculation,
    };
