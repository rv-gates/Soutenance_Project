import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';
import 'package:soutenance_app/pasage/my_new_app.dart';
import 'package:soutenance_app/screen/options/addSomething/add_owner.dart';
import 'package:soutenance_app/screen/options/addSomething/ajout_user/add_driver.dart';
import '../../../widgets/utils.dart';
import 'add_dialog/add_driver_license_dialog.dart';
import 'ajout_carte_grise/add_vehicle.dart';

class DataManagement extends StatefulWidget {
  const DataManagement({super.key});

  @override
  DataManagementState createState() => DataManagementState();
}

class DataManagementState extends State<DataManagement> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer les données'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
        width: 110.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            onPressed: () => showAddDriverDialog(),
            child: const Text(
              'ajouter usager',
              style: TextStyle(fontSize: 11.0),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          width: 110.0,
          child: ElevatedButton(
            onPressed: () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyNewApp())),

            child: const Text(
            'Générer code QR',
            style: TextStyle(fontSize: 11.0),
          ),
        ),
      ),
    ),
    ],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: SizedBox(
    width: 110.0,
    child: ElevatedButton(
    onPressed: () async {
    final result = await showDialog(
    context: context,
    builder: (context) => const AddVehicle(),
    );

    if (!mounted || result == null) return;

    Utils.showSnackBar(context, 'véhicule enrégistrée');
    },
    child: const Text(
    'Ajouter un vehicule',
    style: TextStyle(fontSize: 11.0),
    ),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: SizedBox(
    width: 110.0,
    child: ElevatedButton(
    onPressed: () {
    showDialog(
    context: context,
    builder: (context) => const AddOwner(),
    );
    },
    child: const Text(
    'Ajouter un propriétaire',
    style: TextStyle(fontSize: 11.0),
    ),
    ),
    ),
    ),
    ],
    ),
    ]
    ,
    )
    ,
    );
  }

  Future<void> showAddDriverDialog() async {
    final createdDriver = await showDialog<DriverCreated>(
      context: context,
      builder: (context) => const AddDriver(),
    );

    if (!mounted) return;

    if (createdDriver == null) return;

    Utils.showSnackBar(context, 'conducteur enrégistré');
  }

/*Future<void> showRegisterDriverLicenseDialog() async {
    final driverLicense = await showDialog<DriverLicense>(
      context: context,
      builder: (context) => const AddDriverLicenseDialog(),
    );

    if (!mounted) return;

    if (driverLicense == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        elevation: 7.0,
        content: const Row(
          children: [
            Text('Permis de conduire enregistrer'),
            Spacer(),
            Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        ),
      ),
    );*/
}
