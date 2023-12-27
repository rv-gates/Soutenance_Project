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
  //late final FormControl<bool> _categories;
  List categories = [];

  final bool selected = true;
  late final FormControl<DriverCreated> _driverId;

  @override
  void initState() {
    super.initState();
    _driverId = FormControl(validators: [Validators.required]);
    _driverForm = fb.group({
      "driverId": _driverId,
      "lastname":
      FormControl<String>(value: '', validators: [Validators.required]),
      "firstname":
      FormControl<String>(value: '', validators: [Validators.required]),
      "profession":
      FormControl<String>(value: '', validators: [Validators.required]),
      "civility":
      FormControl<String>(value: '', validators: [Validators.required]),
      "email": FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
      "telephone":
      FormControl<String>(value: '', validators: [Validators.number]),
    });

    _driverLicenseForm = fb.group({
      "id": FormControl<String>(validators: [Validators.required]),
      "type": FormControl<DriverLicenseType>(validators: [Validators.required]),
      "categories": FormArray<DriverLicenseCategory>(
          categories.map((item) => FormControl<DriverLicenseCategory>(),)
              .toList()),


    });

    _form = fb.group({
      'driver': _driverForm,
      'driverLicense': _driverLicenseForm,
    });
  }

  @override
  Widget build(BuildContext context) =>
      AlertDialog(
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
          height: MediaQuery
              .of(context)
              .size
              .height / 2,
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
                      label: "prenom",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.profession",
                      label: "profession",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.email",
                      label: "email",
                      inputType: TextInputType.emailAddress,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.telephone",
                      label: "telephone",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "driver.civility",
                      label: "civility",
                    ),
                  ),

                  Wrap(
                      direction: Axis.horizontal,
                      children: DriverLicenseCategory.values
                          .map(
                            (item) =>

                            ReactiveCheckboxListTile(
                              //formControl: ,
                              formControlName: 'driverLicense.categories',
                              title: Text(item.name),
                              onChanged: (value) {
                                setState(() {
                                  if (selected) {
                                   /* categories.addAll(
                                        categories.map((email) =>
                                            FormControl<bool>(value: true))
                                            .toList());*/
                                    }
                                    });
                              },

                            ),
                      )
                          .toList()),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ReactiveDropdownField<DriverLicenseType>(
                      formControlName: 'driverLicense.type',
                      hint: const Text('Type de permis'),
                      items: DriverLicenseType.values
                          .map((item) =>
                          DropdownMenuItem<DriverLicenseType>(
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
                  onPressed: () => addDriver(),
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

  /*void _CheckboxChange(FormControl<bool> value) {
    setState(() {
      _categories = value;
    });
  }*/

  Future<void> addDriver() async {
    try {
      await ref
          .read(driversService)
          .registerDriver(
        driver: Driver.fromJson(_driverForm.value),
        license: DriverLicense.fromJson({
          ..._driverLicenseForm.value,
          'id': _driverId.value!.id,

        }),
      );
    } catch (e) {
      log('', name: 'REGISTER DRIVER', error: e);
    }
  }
}
