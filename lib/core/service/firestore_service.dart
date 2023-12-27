import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:uuid/uuid.dart';
import '../modele/sanction/sanction.dart';

abstract class FirestoreService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  String get collection;

  Future<List<Map<String, dynamic>>> get docs async {
    try {
      final snapshots = await firestore.collection(collection).get();

      return snapshots.docs.map((item) => item.data()).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> post({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(collection).doc(id).set(data);
    } catch (_) {
      rethrow;
    }
  }

  Future DeleteUser(String data, String id) async {
    // return await _ref
    //     .read(firestoreProvider)
    //     .firestore
    //     .collection('user')
    //     .doc(id)
    //     .delete();
  }

  Future<Driver> addUsager({
    required Driver driver,
  }) async {
    try {
      final createdUsager = DriverCreated.fromJson({
        'id': const Uuid().v4(),
        ...driver.toJson(),
      });

      await firestore
          .collection('usagers')
          .doc(createdUsager.id)
          .set(createdUsager.toJson());
      return createdUsager;
    } catch (_) {
      rethrow;
    }
  }

  Future<VehicleDocument> addCarteGrise({
    required VehicleDocument carteGrise,
  }) async {
    try {
      final createdCarteG = VehicleDocumentCreated.fromJson({
        'id': const Uuid().v4(),
        ...carteGrise.toJson(),
      });

      await firestore
          .collection('carteGrise')
          .doc(createdCarteG.id)
          .set(createdCarteG.toJson());
      return createdCarteG;
    } catch (_) {
      rethrow;
    }
  }

  Future<Sanction> addSanction({
    required Sanction sanction,
  }) async {
    try {
      final createdSanction = SanctionCreated.fromJson({
        'id': const Uuid().v4(),
        ...sanction.toJson(),
      });

      await firestore
          .collection('sanction')
          .doc(createdSanction.id)
          .set(createdSanction.toJson());
      return createdSanction;
    } catch (_) {
      rethrow;
    }
  }
}
/*Future<String> addSanctions({
    required String sanctions,
    //required  description,
  }) async {
    String res = "Some error occured";
    try {
      Sanctions juge = Sanctions(
        matriculation: sanctions,
        //sanctions: description,
        idJugement: const Uuid().v4(),
      );

      final res = await _firestore.collection('sanctions').doc().set(
            juge.toJson(),
          );
    } catch (e) {
      //rethrow;
      log("erreur survenue", error: e);
    }
    return res;
  }
}*/
