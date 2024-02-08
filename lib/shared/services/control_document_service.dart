import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/control_document/control_document.dart';
import 'package:uuid/v4.dart';

import '../../core/service/firestore_service.dart';

final controlService = Provider.autoDispose((ref) => _ControlDocumentService(ref));

class _ControlDocumentService extends FirestoreService {
  final Ref _ref;

  _ControlDocumentService(this._ref);

  @override
  String get collection => 'CONTROLE_DOCUMENT';

  Future <ControlDocumentCreated> registerControlDocument({required ControlDocument document}) async {
    try {
      final id = const UuidV4().generate();
      final dataControl = {
        ...document.toJson(),
        'id': id,
      };

      await super.post(id: id, data: dataControl);

      return ControlDocumentCreated.fromJson(dataControl);
    } catch (_) {
      rethrow;
    }
  }
}