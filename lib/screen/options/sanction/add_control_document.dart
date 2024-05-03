import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/control_document/control_document.dart';
import 'package:soutenance_app/core/modele/sanction/sanction.dart';
import 'package:soutenance_app/shared/services/control_document_service.dart';

import '../../../core/modele/driver/driver.dart';
import '../../../widgets/utils.dart';

class AddControlDocument extends ConsumerStatefulWidget {
  final DriverCreated driver;
  const AddControlDocument({super.key,
    required this.driver
  });

  @override
  ConsumerState createState() => _AddSanctionDialogState();
}

class _AddSanctionDialogState extends ConsumerState<AddControlDocument> {
  final List<Sanction> client = [];
  late final FormGroup _form;
  late final FormControl<DateTime> _dateCtrl;
  final currentUser= FirebaseAuth.instance.currentUser;

  void getDataFromFirebase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('SANCTION').get();
    for (var doc in querySnapshot.docs) {
      setState(() {
        client.add(Sanction(
          sanction: doc['sanction'],
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    _dateCtrl = FormControl(value: null, validators: [Validators.required]);

    _form = fb.group({
      "date": _dateCtrl,
      "sanction": FormControl<Sanction>(validators: [Validators.required]),
    });
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Padding(
          padding: EdgeInsets.only(left: 22.0, top: 15.0),
          child: Text(
            'veuillez saisir le motif pour lequel le véhicule a été arrété',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        content: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ReactiveDropdownField<Sanction>(
                  isExpanded: true,
                  formControlName: 'sanction',
                  hint: const Text('choix de la sanction'),
                  items: client
                      .map<DropdownMenuItem<Sanction>>((Sanction sanctions) {
                    return DropdownMenuItem<Sanction>(
                      value: sanctions,
                      child: Text(sanctions.sanction),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(
                height: 10.0,
              ),

              const Text("cliquer sur ce champ pour afficher la date", style: TextStyle(fontSize: 10.0, color: Colors.blueGrey),),

              SizedBox(
                height: 60.0,
                width: 300.0,
                child: ReactiveTextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  formControl: _dateCtrl,
                  readOnly: true,
                  onTap: (_) => _pickDate(),
                ),
              ),
            ],
          ),
        ),
        actions: [

          TextButton(
            child: const Text('Annuler'),
            onPressed: () => Navigator.of(context).pop(),
          ),

          ElevatedButton(
            onPressed: (){
              registerControl();
              Navigator.of(context).pop();
            },
            child: const Text('Ajouter'),
          ),
        ],
      );

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    _dateCtrl.value = pickedDate;
  }

  Future<void> registerControl() async {
    try {
      if (_form.invalid) return;

      final res =  FirebaseFirestore.instance.collection('USER').where(currentUser!.uid).get();

      final createControl =
          await ref.read(controlService).registerControlDocument(
                document: ControlDocument.fromJson({
                  ..._form.value,
                  'sanction':
                      (_form.controls['sanction']!.value as Sanction).toJson(),
                  'date': _dateCtrl.value!.toIso8601String(),
                  "idDriver": currentUser!.uid,
                  //"idConduc": widget.driver.id,

                }),
              );

      Utils.showSnackBar(context, 'Controle enrégistré');

      if (!mounted) return;
      Navigator.pop<ControlDocumentCreated>(context, createControl);

      Utils.showSnackBar(context, 'Controle enrégistré');

    } catch (e) {
      log("l'erreur est ", error: e);
    }
  }
}
