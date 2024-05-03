import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/shared/services/sanction_service.dart';
import 'package:soutenance_app/widgets/utils.dart';

import '../../core/modele/sanction/sanction.dart';

import '../custom_text_field.dart';

class AddSanction extends ConsumerStatefulWidget {
  const AddSanction({super.key});

  @override
  ConsumerState createState() => _AddSanctionState();
}

class _AddSanctionState extends ConsumerState<AddSanction> {


  late final FormGroup _formSanction;

  @override
  void initState() {
    super.initState();

    _formSanction = fb.group({
      "sanction": FormControl<String>(
          value: '', validators: [Validators.required, Validators.required]),
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'Ajouter une sanction',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: ReactiveForm(
          formGroup: _formSanction,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: CustomTextField(
                  formControlName: "sanction",
                  //  controller: sanctionController,
                  obscureText: false,
                  label: "ajouter une sanction",
                  inputType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: ElevatedButton(
                child: const Text(
                  'Ajouter',
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
                onPressed: () {
                   addSanction();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  Future<void> addSanction() async {
    // if (_formSanction.invalid) return

    if (!mounted) return;

    final createdSanction = await ref.read(sanctionService).registerSanction(
      sanctions : Sanction.fromJson({
        ..._formSanction.value,
      }),
    );

    Navigator.pop<SanctionService>(context,);

    Utils.showSnackBar(context, 'Sacntion enrégistrée');
  }
}
