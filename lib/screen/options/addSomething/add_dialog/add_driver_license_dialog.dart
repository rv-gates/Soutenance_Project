import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';
import 'package:soutenance_app/screen/options/addSomething/add_dialog/add_dialog_notifier.dart';
import 'package:soutenance_app/shared/enums/driver_license_category.dart';
import 'package:soutenance_app/shared/enums/driver_license_type.dart';
import 'package:soutenance_app/shared/services/driver_licenses_service.dart';
import '../../../../core/modele/driver/driver.dart';
import '../../../../widgets/custom_text_field.dart';

class AddDriverLicenseDialog extends ConsumerStatefulWidget {
  const AddDriverLicenseDialog({super.key});

  @override
  ConsumerState createState() => _AddDriverLicenseDialogState();
}

class _AddDriverLicenseDialogState
    extends ConsumerState<AddDriverLicenseDialog> {
  late final FormGroup _driverLicenseForm;
  late final FormControl<DriverCreated> _userCtrl;

  @override
  void initState() {
    super.initState();

    _userCtrl = FormControl<DriverCreated>(validators: [Validators.required]);



    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(addDialogProvider.notifier).fetchUsers());
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Ajouter un agent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: _driverLicenseForm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  const SizedBox(height: 5.0),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "id",
                      label: "Numéro permis",
                      isEmpty:'Le munéro ne doit pas etre vide',
                      validate: 'entrez un numéro valide',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ReactiveDropdownField<DriverLicenseType>(
                      formControlName: 'type',
                      hint: const Text('Type de permis'),
                      items: DriverLicenseType.values
                          .map((item) => DropdownMenuItem<DriverLicenseType>(
                                value: item,
                                child: Text(item.name),
                              ))
                          .toList(),
                    ),
                  ),

                  Wrap(
                      direction: Axis.horizontal,
                      children: DriverLicenseCategory.values
                          .map((item) => ReactiveCheckboxListTile(
                                formControlName: 'categories',
                                title: Text(item.name),
                              ))
                          .toList()),

                  ReactiveDropdownField(
                    items: const [],
                    formControlName: 'user',
                    hint: const Text('User'),
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
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(
                width: 9.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: registerDriverLicense,
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

  Future<void> registerDriverLicense() async {
    if (_driverLicenseForm.invalid) return;

    final driverLicense = DriverLicense.fromJson({
      ..._driverLicenseForm.value,
      'userId': _userCtrl.value!.id,
    });

    //await ref.read(driverLicensesService).registerDriverLicense(driverLicense);

    if (!mounted) return;

    Navigator.pop<DriverLicense>(context, driverLicense);
  }
}
