import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/modele/carte_grise/vehicle_document.dart';
import 'package:soutenance_app/core/modele/owner/owner.dart';
import 'package:soutenance_app/core/modele/vehicule/vehicle.dart';
import 'package:soutenance_app/shared/enums/genders.dart';
import 'package:soutenance_app/shared/enums/vehicle_document_type.dart';
import 'package:soutenance_app/shared/services/vehicles_service.dart';

import '../../../../widgets/custom_text_field.dart';

class AddVehicle extends ConsumerStatefulWidget {
  const AddVehicle({super.key});

  @override
  ConsumerState createState() => _AddVehicleState();
}

class _AddVehicleState extends ConsumerState<AddVehicle> {
  late final FormGroup _vehicleForm;
  late final FormGroup _vehicleDocumentForm;
  late final FormControl<OwnerCreated> _ownerCtrl;
  late final FormControl<VehicleDocumentType> _vehicleDocumentTypeCtrl;

  @override
  void initState() {
    super.initState();

    _ownerCtrl = FormControl<OwnerCreated>(validators: [Validators.required]);

    _vehicleDocumentTypeCtrl =
        FormControl<VehicleDocumentType>(validators: [Validators.required]);

    _vehicleDocumentForm = fb.group({
      'owner': _ownerCtrl,
      'licensePlate':
          FormControl<String>(value: '', validators: [Validators.required]),
      "serialNumber":
          FormControl<String>(value: '', validators: [Validators.required]),
      "allowedWeight":
          FormControl<String>(value: '', validators: [Validators.required]),
      "administrativePower":
          FormControl<String>(value: '', validators: [Validators.required]),
      "vehicleDocumentType": _vehicleDocumentTypeCtrl,
    });

    _vehicleForm = fb.group({
      "mark": FormControl<String>(validators: [Validators.required]),
      'vehicleDocument': _vehicleDocumentForm,
    });
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Ajouter un vehicle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: _vehicleForm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  const SizedBox(height: 5.0),

                  ReactiveDropdownField<OwnerCreated>(
                    formControlName: 'vehicleDocument.owner',
                    hint: const Text('Propriétaire'),
                    items: const [
                      //
                      DropdownMenuItem<OwnerCreated>(
                        value: OwnerCreated(
                          id: 'ABC123',
                          lastName: 'IBATA',
                          firstName: 'Herllias',
                          phoneNumber: '06 615 82 91',
                          civility: 'monsieur',
                          gender: Genders.male,
                        ),
                        child: Text('Herllias IBATA'),
                      ),

                      DropdownMenuItem<OwnerCreated>(
                        value: OwnerCreated(
                          id: 'CDE456',
                          lastName: 'DELUCIS',
                          firstName: 'Steeven',
                          phoneNumber: '05 045 78 60',
                          civility: 'monsieur',
                          gender: Genders.male,
                        ),
                        child: Text('Steeven DELUCIS'),
                      ),

                      DropdownMenuItem<OwnerCreated>(
                        value: OwnerCreated(
                          id: 'FGH789',
                          lastName: 'NGOULOU',
                          firstName: 'Hervé',
                          phoneNumber: '06 960 45 32',
                          civility: 'madale',
                          gender: Genders.female,
                        ),
                        child: Text('Hervé NGOULOU'),
                      )
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      // controller: lastNameController,
                      formControlName: "vehicleDocument.licensePlate",
                      label: "Immatriculation",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      // controller: firstNameController,
                      formControlName: "mark",
                      label: "Marque du véhicule",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "vehicleDocument.serialNumber",
                      label: "Numéro de serie",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      // controller: firstNameController,
                      formControlName: "vehicleDocument.allowedWeight",
                      label: "Poids autorise",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      // controller: firstNameController,
                      formControlName: "vehicleDocument.administrativePower",
                      label: "Puissance administrative",
                    ),
                  ),

                  ReactiveDropdownField<VehicleDocumentType>(
                    formControlName: 'vehicleDocument.vehicleDocumentType',
                    hint: const Text('Type de carte grise'),
                    items: VehicleDocumentType.values
                        .map((type) => DropdownMenuItem<VehicleDocumentType>(
                              value: type,
                              child: Text(type.name),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              //
              ElevatedButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(fontSize: 12.0),
                ),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(width: 9.0),

              Expanded(
                child: ElevatedButton(
                  onPressed: addVehicle,
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

  Future<void> addVehicle() async {
    try {
      if (_vehicleForm.invalid) return;

      final createdVehicle = await ref.read(vehiclesService).registerVehicle(
            vehicle: Vehicle.fromJson(_vehicleForm.value),
            vehicleDocument: VehicleDocument.fromJson({
              ..._vehicleDocumentForm.value,
              'ownerId': _ownerCtrl.value!.id,
              'vehicleDocumentType': _vehicleDocumentTypeCtrl.value!.name
            }),
          );

      if (!mounted) return;

      Navigator.pop<VehicleCreated>(context, createdVehicle);
    } catch (e) {
      log('', name: 'ADD VEHICULE', error: e);
    }
  }
}
