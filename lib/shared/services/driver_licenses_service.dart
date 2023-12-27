import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:uuid/v4.dart';

import '../../core/modele/permis/driver_license.dart';

final driverLicensesService =
    Provider.autoDispose((ref) => _DriverLicencesService(ref));

class _DriverLicencesService extends FirestoreService {
  final Ref _ref;

  _DriverLicencesService(this._ref);
  @override
  String get collection => 'DRIVER_LICENSES';

  Future<DriverLicenseCreated> registerDriverLicense(DriverLicense license) async {
    try {

      final id = const UuidV4().generate();
      final data = {
        ...license.toJson(),
        'id' : id,
      };
      await super.post(id: id, data: data);

      return DriverLicenseCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }
}
