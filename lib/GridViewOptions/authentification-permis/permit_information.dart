import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/GridViewOptions/authentification-permis/scan_page.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';

import '../../screen/options/sanction/add_control_document.dart';

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
  DriverLicenseCreated? driverLicenses;

  void route() async{
    final snapsnot = await FirebaseFirestore.instance.collection("DRIVER").doc(driverLicenses!.id).get();
    final snap=snapsnot.get('type');

  }

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
    if (isFetchingData)
      return  Center(
          child: SizedBox.square(
              dimension: 30, child: CircularProgressIndicator()));

    if (error != null)
      return const Center(child: Text('Une erreur est survenue'));

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Center(
                  child: Text(
                    'Nom:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '  ${driver!.lastname.toString()}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5.0),

          const Divider(thickness: 5),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Prénom: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),

                Text(
                  ' ${driver!.firstname.toString()}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),



          const Divider(thickness: 5),

          driver!.firstname == "Daniella" || driver!.firstname == "richel"
              ? const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Permis valide ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Permis non valide ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600),
                  ),
                ),
          /*if(driver != null)
           const Padding(
               padding: EdgeInsets.only(top: 12.0),
               child:
               Text(
                 'Permis valide ',
                 style: TextStyle(fontSize: 16,
                     color: Colors.redAccent,
                     fontWeight: FontWeight.w600),
               ),
             ),*/

          const Divider(thickness: 5),

             const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "B,C,D",
              //driverLicenses!.categories.toString()
              // ,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),

          const Divider(thickness: 5),

          const SizedBox(height: 30.0),

          SizedBox(
            width: 150.0,
            height: 40.0,
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScanPage())),
              child: const Text('Retour'),
            ),
          ),

          const SizedBox(height: 30.0),

          SizedBox(
            width: 150.0,
            height: 50.0,
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
      dynamic snapshot = await FirebaseFirestore.instance
          .collection('DRIVER_LICENSES')
          .doc(widget.driverLicenseId)
          .get();

      Map<String, dynamic> driverLicense = snapshot.data();
      //driverLicenses= driverLicense as DriverLicenseCreated?;
      DriverLicenseCreated? driverLicenses =
          DriverLicenseCreated.fromJson(driverLicense);

      snapshot = await FirebaseFirestore.instance
          .collection('DRIVERS')
          .where('driverLicenseId', isEqualTo: widget.driverLicenseId)
          .limit(1)
          .get();

      driver = DriverCreated.fromJson(snapshot.docs[0].data());


      if (!mounted) return;

      if (snapshot != snapshot) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              const AlertDialog(title: Text("Données non trouver")),
        );
        return;
      }

      setState(() {});
    } on Exception catch (err) {
      log(err.toString(), name: 'ERROR');

      setState(() => error = err);
    } finally {
      setState(() => isFetchingData = false);
    }
  }

  void _openSanction() {
    if (driver != null) {
      showDialog(
          context: context,
          builder: (context) => AddControlDocument(driver: driver!));
    } else {
      return;
    }
  }
}
