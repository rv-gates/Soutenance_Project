import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/owner/owner.dart';
import '../../../../shared/services/driver_licenses_service.dart';
import '../../../../widgets/custom_text_field.dart';


class AddOwner extends ConsumerStatefulWidget {
  const AddOwner({super.key});

  @override
  ConsumerState createState() => _AddOwnerState();
}

class _AddOwnerState extends ConsumerState<AddOwner> {

  late final FormGroup _ownerForm;

  @override
  void initState() {
    super.initState();


    _ownerForm = fb.group({
      "lastName": FormControl<String>(value: '', validators: [Validators.required]),
      "firstName": FormControl<String>(value: '', validators: [Validators.required]),
      "phoneNumber": FormControl<String>(value: '', validators: [Validators.required]),
      "civility": FormControl<String>(value: '', validators: [Validators.required]),
      "gender": FormControl<String>(value: '', validators: [Validators.required]),

    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Ajouter un propriétaire',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: _ownerForm,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: SingleChildScrollView(
                    child: CustomTextField(
                        formControlName: "lastName",
                        label: "nom",
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      formControlName: "firstName",
                      label: "prenom",
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      formControlName: "phoneNumber",
                      label: "Numéro de téléphone",
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      formControlName: "civility",
                      obscureText: false,
                      label: "civilité",
                      ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      formControlName: "gender",
                      obscureText: false,
                      label: "genre",
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
              child: const Text(
                'Annuler',
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 9.0,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  registerOwner();
                },
                child: const Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Future<void> registerOwner() async {
    if (_ownerForm.invalid) return;
  }
}
