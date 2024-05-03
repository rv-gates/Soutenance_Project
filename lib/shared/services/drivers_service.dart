import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/shared/services/driver_licenses_service.dart';
import 'package:uuid/v4.dart';

import '../../core/modele/driver/driver.dart';
import '../../core/modele/user.dart';

final driversService = Provider.autoDispose((ref) => _DriversService(ref));

class _DriversService extends FirestoreService {
  final Ref _ref;

  _DriversService(this._ref);

  @override
  String get collection => 'DRIVERS';

  Future<List<DriverCreated>> get drivers async {
    try {
      final docs = await super.docs;

      return docs.map((item) => DriverCreated.fromJson(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<DriverCreated> getUser(String id) async{
    try{
      final data= await super.getDoc(id);
      if(data == null) throw Exception("une erreur s'est produite");
      return DriverCreated.fromJson(data);

    } catch(e){
      rethrow;
    }
  }

  Future<DriverCreated> registerDriver({required Driver driver, required DriverLicense license}) async {
    try {
      final createdLicense = await _ref.read(driverLicensesService).registerDriverLicense(license);

      final id = const UuidV4().generate();
      final data = {
        ...driver.toJson(), // crée un format pouvant etre enrégistrer sur Firebase
        'id': id,
        'driverLicenseId': createdLicense.id,
      };

      await super.post(id: id, data: data);

      return DriverCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
