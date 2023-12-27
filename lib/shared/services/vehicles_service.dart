import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/shared/services/vehicle_documents_service.dart';
import 'package:uuid/v4.dart';

import '../../core/modele/vehicule/vehicle.dart';

final vehiclesService = Provider.autoDispose((ref) => _VehiclesService(ref));

class _VehiclesService extends FirestoreService {
  final Ref _ref;

  _VehiclesService(this._ref);

  @override
  String get collection => 'VEHICLES';

  Future<VehicleCreated> registerVehicle({
    required Vehicle vehicle,
    required VehicleDocument vehicleDocument,
  }) async {
    try {
      final createdVehicleDocument = await _ref
          .read(vehicleDocumentsService)
          .registerVehicleDocument(vehicleDocument);

      final id = const UuidV4().generate();
      final data = {
        ...vehicle.toJson(),
        'id': id,
        'vehicleDocumentId': createdVehicleDocument.id,
      };

      await super.post(id: id, data: data);

      return VehicleCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
