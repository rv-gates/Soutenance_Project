import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:uuid/v4.dart';

final vehicleDocumentsService =
    Provider.autoDispose((ref) => VehicleDocumentsService());

class VehicleDocumentsService extends FirestoreService {
  @override
  String get collection => 'VEHICLE_DOCUMENTS';

  Future<List<VehicleDocumentCreated>> get vehicleDocument async {
    try {
      final docs = await super.docs;
      return docs.map((item) => VehicleDocumentCreated.fromJson(item)).toList();
    } catch (_) {
      rethrow;
    }
  }


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

  Future<VehicleDocumentCreated> getVehicle(String id) async{
    try{
      final data= await super.getDoc(id);
      if(data == null) throw Exception("une erreur s'est produite");
      return VehicleDocumentCreated.fromJson(data);

    } catch(e){
      rethrow;
    }
  }
}
