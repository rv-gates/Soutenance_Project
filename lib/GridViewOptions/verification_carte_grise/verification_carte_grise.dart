import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/shared/services/vehicle_documents_service.dart';
import 'package:soutenance_app/widgets/custom_text_field.dart';
import '../../core/modele/permis/driver_license.dart';
import '../../widgets/text_widget.dart';

class VerificationCarteGrise extends ConsumerStatefulWidget {
final String licensePlate;

  const VerificationCarteGrise(this.licensePlate, {super.key});

  @override
  ConsumerState createState() => _VerificationCarteGriseState();
}

class _VerificationCarteGriseState
    extends ConsumerState<VerificationCarteGrise> {
  late final FormGroup _form;
  bool isConnect = true;
  late final FormControl licencePlate;


  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    licencePlate = FormControl<String>(validators: [Validators.required]);
    _form = fb.group({
      "licensePlate": licencePlate,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnect) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Erreur de connexion',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Veuillez vérifier votre connexion Internet 🤖🥲',
                  style: TextStyle(fontSize: 11.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("retour")),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Vérification Carte Grise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ReactiveForm(
            formGroup: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(18.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        'images/carte_grise.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Veuillez saisir les informations suivantes :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.height / 2,
                  child: const CustomTextField(
                      formControlName: "licensePlate",
                      obscureText: false,
                      label: "Numéro d\'immatriculation du véhicule",
                      inputType: TextInputType.text),
                ),
                /*const SizedBox(height: 16.0),
              TextPlace(
                  controller: permisController,
                  obscureText: false,
                  labelText: "Numéro de permis de conduire",
                  textInputType: TextInputType.text),
              const SizedBox(height: 16.0),*/
                /*TextField(
                inputFormatters: [
                  CurrencyTextInputFormatter(name: 'AA-111-AA'),
                ],
                onChanged: (value) {
                  bool isValid = regExp.hasMatch(value.toUpperCase());
                  // Faites quelque chose avec le résultat de la correspondance
                },
              ),*/

                /* const SizedBox(height: 16.0),
              TextPlace(
                  controller: identityController,
                  obscureText: false,
                  labelText: "Numéro de carte d'identité",
                  textInputType: TextInputType.text),*/
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    buildNewPage(licencePlate.value);
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarteGriseScreen()));
                  },
                  child: const Text('Vérifier'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> buildNewPage(String userInput) async {
    try {

      dynamic snapshot = await FirebaseFirestore.instance
          .collection('VEHICLE_DOCUMENTS')
          .doc("417dc9d2-5a6a-4e93-8e29-d7f85075e994")
          .get();

      Map<String, dynamic> driverLicense = snapshot.data();
      VehicleDocumentCreated? driverLicenses =
      VehicleDocumentCreated.fromJson(driverLicense);


      if (userInput == driverLicenses.licensePlate.toString()) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Column(
              children: [
                Text("carte grise valide"),
              ],
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);

              }, child: const Text("Annuler")),
              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: FutureBuilder<VehicleDocumentCreated>(
                            future:ref.read(vehicleDocumentsService).getVehicle("417dc9d2-5a6a-4e93-8e29-d7f85075e994"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final user = snapshot.data!;
                                //final result = ref.read(driversService).getUser(doc.idConduct);
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 16.0),
                                      const TextWidget(
                                          text: "Numéro d'immatriculation  ",
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                      const SizedBox(height: 5.0),
                                      Center(
                                        child: Text(
                                          driverLicenses.licensePlate.toString(),
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const SizedBox(height: 8.0),
                                      const Center(
                                        child: TextWidget(
                                            text: 'Numéro de carte grise ',
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Center(
                                        child: Text(
                                          user.serialNumber,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                      ),

                                      const SizedBox(height: 16.0),
                                      const Center(
                                        child: TextWidget(
                                            text: "type document  ",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Center(
                                        child: Text(
                                          user.vehicleDocumentType.name,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                      ),

                                      const SizedBox(height: 16.0),
                                      const Center(
                                        child: TextWidget(
                                            text: "Puissance du véhicule",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Center(
                                        child: Text(
                                          user.administrativePower,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                      ),

                                      const SizedBox(height: 16.0),
                                      const Center(
                                        child: TextWidget(
                                            text: "Poids du véhicule",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Center(
                                        child: Text(
                                          user.allowedWeight,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ],
                                );
                              }

                              return const CircularProgressIndicator();
                            }),

                        /*FutureBuilder<VehicleDocumentCreated>(
                            future: ref
                                .read(vehicleDocumentsService)
                                .getVehicle(
                                    "417dc9d2-5a6a-4e93-8e29-d7f85075e994"),
                            builder: (context, snapshot) {
                              final vehicleDocument = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 16.0),
                                  const TextWidget(
                                      text: "Numéro d'immatriculation  ",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Text(
                                      driverLicenses.licensePlate.toString(),
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  const SizedBox(height: 8.0),
                                  const Center(
                                    child: TextWidget(
                                        text: 'Numéro de carte grise ',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Center(
                                    child: Text(
                                      vehicleDocument.serialNumber,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                ],
                              );
                            }),*/
                        /*SizedBox(
                                  width: 200.0,
                                  height: 40.0,
                                  child: ElevatedButton(
                                      onPressed: () {
                                      },
                                      child: const Text(
                                        'Appliquer une sanction',
                                        style: TextStyle(fontSize: 12.0),
                                      ))),*/
                      ),
                    );
                  },
                  child: const Text("Continuer")),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              const AlertDialog(title: Text("carte grise invalide")),
        );
      }

    } catch (e) {
      log(e.toString(), name: 'erreur lors de la vérification');
    }
  }
}
