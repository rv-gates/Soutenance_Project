import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/permis/driver_license.dart';
import 'package:soutenance_app/shared/enums/driver_license_category.dart';
import 'package:soutenance_app/shared/enums/driver_license_type.dart';

import '../../../../core/modele/driver/driver.dart';
import '../../../../shared/services/drivers_service.dart';
import '../../../../widgets/custom_text_field.dart';

class AddDriver extends ConsumerStatefulWidget {
  const AddDriver({super.key});

  @override
  ConsumerState createState() => _AddDriverState();
}

class _AddDriverState extends ConsumerState<AddDriver> {
  late final FormGroup _form, _driverForm, _driverLicenseForm;

  final bool selected = true;

  @override
  void initState() {
    super.initState();

    _driverForm = fb.group({
      "lastname": FormControl<String>(value: '', validators: [Validators.required]),
      "firstname": FormControl<String>(value: '', validators: [Validators.required]),
      "profession": FormControl<String>(value: '', validators: [Validators.required]),
      "civility": FormControl<String>(value: '', validators: [Validators.required]),
      "email": FormControl<String>(value: '', validators: [Validators.required, Validators.email]),
      "telephone": FormControl<String>(value: '', validators: [Validators.number]),
    });

    _driverLicenseForm = fb.group({
      "type": FormControl<DriverLicenseType>(validators: [Validators.required]),
      "categories": FormArray<bool>(
        DriverLicenseCategory.values.map((category) => FormControl<bool>()).toList(),
        validators: [Validators.required],
      ),
    });

    _form = fb.group({
      'driver': _driverForm,
      'driverLicense': _driverLicenseForm,
    });
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
          height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  const SizedBox(height: 5.0),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: SingleChildScrollView(
                      child: CustomTextField(
                        formControlName: "driver.lastname",
                        label: "nom",
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.firstname",
                      label: "Prénom",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.profession",
                      label: "Profession",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.email",
                      label: "Email",
                      inputType: TextInputType.emailAddress,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.telephone",
                      label: "Téléphone",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.civility",
                      label: "Civilité",
                    ),
                  ),

                  ...DriverLicenseCategory.values
                      .map((category) => ReactiveCheckboxListTile(
                            formControlName: 'driverLicense.categories.${category.index}',
                            title: Text(category.name),
                          ))
                      .toList(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ReactiveDropdownField<DriverLicenseType>(
                      formControlName: 'driverLicense.type',
                      hint: const Text('Type de permis'),
                      items: DriverLicenseType.values
                          .map((item) => DropdownMenuItem<DriverLicenseType>(
                                value: item,
                                child: Text(item.name),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          //
          ElevatedButton(
            child: const Text('Annuler', style: TextStyle(fontSize: 12.0)),
            onPressed: () => Navigator.pop(context),
          ),

          const SizedBox(width: 9.0),

          Expanded(
            child: ElevatedButton(
              onPressed: registerDriver,
              child: const Text('Ajouter', style: TextStyle(fontSize: 12.0)),
            ),
          ),
        ],
      );

  Future<void> registerDriver() async {
    try {
      final categoriesArray = _driverLicenseForm.control('categories') as FormArray;

      final selectedCategories = categoriesArray.controls
          .where((control) => control.value == true)
          .map((control) => DriverLicenseCategory.values[categoriesArray.controls.indexOf(control)])
          .toList();

      final createdDriver = await ref.read(driversService).registerDriver(
            driver: Driver.fromJson(_driverForm.value),
            license: DriverLicense.fromJson({
              'type': (_driverLicenseForm.control('type') as FormControl<DriverLicenseType>).value!.name,
              'categories': selectedCategories.map((category) => category.name).toList(),
            }),
          );

      if (!mounted) return;

      Navigator.pop(context, createdDriver);
    } catch (e) {
      log('', name: 'REGISTER DRIVER', error: e);
    }
  }
}
