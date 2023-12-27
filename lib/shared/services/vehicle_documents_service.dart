import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:uuid/v4.dart';

final vehicleDocumentsService =
    Provider.autoDispose((ref) => VehicleDocumentsService());

class VehicleDocumentsService extends FirestoreService {
  @override
  String get collection => 'VEHICLE_DOCUMENTS';

  Future<VehicleDocumentCreated> registerVehicleDocument(
      VehicleDocument vehicleDocument) async {
    try {
      final id = const UuidV4().generate();

      final data = {...vehicleDocument.toJson(), 'id': id};
      await super.post(id: id, data: data);

      return VehicleDocumentCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
