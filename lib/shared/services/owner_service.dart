import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:uuid/v4.dart';

import '../../core/modele/owner/owner.dart';

class _OwnerService extends FirestoreService {
  final Ref _ref;

  _OwnerService(this._ref);

  @override
  String get collection => 'OWNERS';

  Future<OwnerCreated> registerOwner({required Owner owner}) async {
    try {
      final id = const UuidV4().generate();
      final dataOwner = {
        ...owner.toJson(),
        'id': id,
      };

      return OwnerCreated.fromJson(dataOwner);
    } catch (_) {
      rethrow;
    }
  }
}
