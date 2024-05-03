import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';
import 'package:soutenance_app/pasage/my_new_app.dart';
import 'package:soutenance_app/screen/options/addSomething/add_owner.dart';
import 'package:soutenance_app/screen/options/addSomething/ajout_user/add_driver.dart';
import 'package:soutenance_app/widgets/verification_card.dart';
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
        title: const Text('Gérer les données', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding:
                  const EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
              mainAxisSpacing: 46.0,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyNewApp()));
                  },
                  child: const Card(
                    color: Colors.white38,
                    elevation: 20.0,
                    child: VerificationCard(
                      title: 'Génerer le QRcode',
                      icon: Icons.qr_code_2_outlined,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                     showAddDriverDialog();
                    if (!mounted) return;

                  },
                  child: const Card(
                    color: Colors.white38,
                    elevation: 20.0,
                    child: VerificationCard(
                      title: 'Ajouter un usager',
                      icon: Icons.person_add,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => const AddVehicle(),
                    );
                    if (!mounted || result == null) return;

                    Utils.showSnackBar(context, 'véhicule enrégistré');
                  },
                  child: const Card(
                    color: Colors.white38,
                    elevation: 20.0,
                    child: VerificationCard(
                      title: 'Ajouter un véhicule',
                      icon: Icons.car_rental,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
               /* InkWell(
                  onTap: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => const AddOwner(),
                    );
                    if (!mounted || result == null) return;

                    Utils.showSnackBar(context, 'Propriétaire enrégistré');
                  },
                  child: const Card(
                    color: Colors.white38,
                    elevation: 20.0,
                    child: VerificationCard(
                      title: 'ajouter un propriétaire',
                      icon: Icons.person,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),*/
              ],
            ),
          ),

          /*Row(
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
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const MyNewApp())),
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
          ),*/
        ],
      ),
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
