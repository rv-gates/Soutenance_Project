import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/sanction/sanction.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:uuid/v4.dart';

final sanctionService = Provider.autoDispose((ref) => SanctionService());

class SanctionService extends FirestoreService {
  @override
  String get collection => 'SANCTION';

  Future<SanctionCreated> registerSanction({required Sanction sanctions}) async {
    try {
       final id = const UuidV4().generate();
       final data = {
         ...sanctions.toJson(),
         'id' : id,
       };
       await super.post(id: id, data: data);
       return SanctionCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
