import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/GridViewOptions/verification_carte_grise/carte_grise_screen.dart';
import 'package:soutenance_app/widgets/custom_text_field.dart';

class VerificationCarteGrise extends StatefulWidget {
  @override
  State<VerificationCarteGrise> createState() => VerificationCarteGriseState();
}

class VerificationCarteGriseState extends State<VerificationCarteGrise> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = fb.group({
      "licensePlate": FormControl<String>(validators: [Validators.required]),
    });
  }

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.height/2,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarteGriseScreen()));
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
