import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/control_document/control_document.dart';
import 'package:soutenance_app/core/modele/sanction/sanction.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/shared/services/control_document_service.dart';

class AddSanctionDialog extends ConsumerStatefulWidget {
  const AddSanctionDialog({super.key});

  @override
  ConsumerState createState() => _AddSanctionDialogState();
}

class _AddSanctionDialogState extends ConsumerState<AddSanctionDialog> {
  var selectedCurrency, selectedType;
  DateTime? _selectDate;
  bool _isSecret = false;
  final List<DropdownMenuItem> clientItems = [];
  final List<Sanction> client = [];

  late TextEditingController sanctionController;
  late TextEditingController descriptionController;
  late final FormGroup _formControl, form;

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
    _formControl = fb.group({
      "date": FormControl(validators: [Validators.required]),
      "sanction": FormControl<Sanction>(validators: [Validators.required]),
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return AlertDialog(
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
        formGroup: _formControl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: usersCollection.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<User> users = snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return User(data['id'], data['name']);
                  }).toList();

                  FormBuilder(
                    child: Column(
                      children: <Widget>[
                        FormBuilderDropdown<User>(
                          name: 'user',
                          decoration: InputDecoration(labelText: 'Select User'),
                          items: users
                              .map((user) => DropdownMenuItem(
                            value: user,
                            child: Text(user.name),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ReactiveDropdownField<Sanction>(
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

            /*StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('SANCTION').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");

                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data?.docs[i] as DocumentSnapshot<Object?>;
                      currencyItems.add(
                        DropdownMenuItem(
                          value: "${snap['sanction']}",
                          child: Text(
                            snap['sanction'],
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 190.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButton(
                        items: currencyItems,
                        onChanged: (currencyValue) {
                          setState(() {
                            selectedCurrency = currencyValue;
                          });
                        },
                        value: selectedCurrency,
                        isExpanded: false,
                        hint: const Text(
                          "selectionner sanction",
                          style: TextStyle(),
                        ),
                      ),
                    );

                }),*/
            /*StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('SANCTION').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                if (snapshot.hasError) {
                  print("error");
                }
                if (snapshot.hasData) {
                  final sanctions = snapshot.data?.docs.reversed.toList();
                  clientItems.add(const DropdownMenuItem(
                      value: "0", child: Text("select sanction")));
                  for (var sanction in sanctions!) {
                    clientItems.add(DropdownMenuItem(
                        value: sanction.id, child: Text(sanction['sanction'])));
                  }
                } else {
                  const CircularProgressIndicator();
                }
                return Container(
                  width: 190.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton(
                    value: selectValue,
                    isExpanded: true,
                    items: clientItems,
                    onChanged: (clientValue) {
                      setState(() {
                        selectValue = clientValue;
                      });
                      print(clientValue);
                    },
                  ),
                );
              },
            ),*/
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60.0,
              width: 300.0,
              child: ReactiveTextField(
                formControlName: 'date',
                readOnly: true,
                onChanged: ( change){

                   change;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: InkWell(
                    onTap: () => {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      ),
                      if (_selectDate != null)
                        {
                          _selectDate = _formControl.control('date').value,
                        }
                    },
                    child: Icon(
                      !_isSecret ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),

            /*DateTimeFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Entrer une date',
                  suffixIcon: Icon(Icons.event)),
              mode: DateTimeFieldPickerMode.date,
              validator: (e) => (e?.day ?? 0) == 1 ? 'please mec' : null,
              onDateSelected: (DateTime? value) {
                setState(() {
                  //selectedTime = value;
                });
              },
            ),*/
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Annuler'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          onPressed: registerControl,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }

  Future<void> registerControl() async {
    try {
      if (_formControl.invalid) return;

      final createControl =
          await ref.read(controlService).registerControlDocument(
                document: ControlDocument.fromJson(_formControl.value),
              );

      if (!mounted) return;

      Navigator.pop<ControlDocumentCreated>(context, createControl);
      print(_formControl);
    } catch (e) {
      log("l'erreur est ", error: e);
    }
  }
}
