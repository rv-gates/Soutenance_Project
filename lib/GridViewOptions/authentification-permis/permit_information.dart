import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/GridViewOptions/authentification-permis/scan_page.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';

import '../../screen/options/sanction/add_sanction.dart';

class PermitInformation extends StatefulWidget {
  final String driverLicenseId;

  const PermitInformation({super.key, required this.driverLicenseId});

  @override
  State<PermitInformation> createState() => _PermitInformationState();
}

class _PermitInformationState extends State<PermitInformation> {
  late bool isFetchingData;
  Exception? error;

  Map<String, dynamic>? driverLicense;
  DriverCreated? driver;

  @override
  void initState() {
    super.initState();

    isFetchingData = true;

    fetchData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _buildView(),
      );

  Widget _buildView() {
    if (isFetchingData) return const Center(child: SizedBox.square(dimension: 30, child: CircularProgressIndicator()));

    if (error != null) return const Center(child: Text('Une erreur est survenue'));

    return _buildDataView();
  }

  Widget _buildDataView() => Column(
        children: [
          //
          const SizedBox(height: 30),

          const CircleAvatar(
            radius: 80,
            child: Icon(Icons.person),
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nom: ${driver!.lastname}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 5.0),

          const Divider(thickness: 5),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Prénom: ${driver!.firstname}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 10),

          const Divider(thickness: 5),

          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Permis valide ou non valide',
              style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 10),

          const Divider(thickness: 5),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Catégorie du permis: A,B,C',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),

          const Divider(thickness: 5),

          const SizedBox(height: 30.0),

          SizedBox(
            width: 150.0,
            height: 40.0,
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScanPage())),
              child: const Text('Retour'),
            ),
          ),

          const SizedBox(height: 30.0),

          SizedBox(
            width: 150.0,
            height: 40.0,
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: _openSanction,
              child: const Text('Appliquer une sanction'),
            ),
          ),
        ],
      );

  Future<void> fetchData() async {
    try {
      dynamic snapshot =
          await FirebaseFirestore.instance.collection('DRIVER_LICENSES').doc(widget.driverLicenseId).get();
      if (!snapshot.exists) return;

      driverLicense = snapshot.data();

      snapshot = await FirebaseFirestore.instance
          .collection('DRIVERS')
          .where('driverLicenseId', isEqualTo: widget.driverLicenseId)
          .limit(1)
          .get();

      driver = DriverCreated.fromJson(snapshot.docs[0].data());

      if (!mounted) return;

      // if (!snapshot.exists) {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) => const AlertDialog(title: Text("Donnees non trouver")),
      //   );
      //   return;
      // }

      setState(() {});
    } on Exception catch (err) {
      log(err.toString(), name: 'ERROR');
      setState(() => error = err);
    } finally {
      setState(() => isFetchingData = false);
    }
  }

  void _openSanction() => showDialog(context: context, builder: (context) => const AddSanctionDialog());
}
