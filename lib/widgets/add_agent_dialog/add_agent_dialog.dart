import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../core/modele/user.dart';
import '../../core/service/authentification_service.dart';
import '../../shared/enums/role_user.dart';
import '../custom_text_field.dart';

class AddAgentDialog extends ConsumerStatefulWidget {
  const AddAgentDialog({super.key});

  @override
  ConsumerState createState() => _AddAgentDialogState();
}

class _AddAgentDialogState extends ConsumerState<AddAgentDialog> {
  late final FormGroup _form;
  late final FormControl _passwordCtlr;

  @override
  void initState() {
    super.initState();

    _passwordCtlr = FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(8)]);

    _form = fb.group({
      "email": FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
      "firstName":
          FormControl<String>(value: '', validators: [Validators.required]),
      "lastName":
          FormControl<String>(value: '', validators: [Validators.required]),
      "matricule":
          FormControl<String>(value: '', validators: [Validators.required]),
      "password": _passwordCtlr,
      "role": FormControl<RoleUser>(
           validators: [Validators.required]),
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
            'Ajouter un agent',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: _form,
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: SingleChildScrollView(
                    child: CustomTextField(
                        //controller: emailController,
                        formControlName: "email",
                        label: "Adresse mail par défaut",
                        inputType: TextInputType.emailAddress),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      // controller: lastNameController,
                      formControlName: "firstName",
                      label: "Nom",
                      ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      // controller: firstNameController,
                      formControlName: "lastName",
                      label: "prénom",
                     ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      //controller: matriculeController,
                      formControlName: "matricule",
                      label: "matricule",
                      ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CustomTextField(
                      formControlName: "password",
                      // controller: passwordController,
                      obscureText: false,
                      label: "mot de passe par default",
                      ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ReactiveDropdownField<RoleUser>(
                    formControlName: 'role',
                    hint: const Text("catégorie de l'agent"),
                    items: RoleUser.values
                        .map((item) => DropdownMenuItem<RoleUser>(
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 9.0,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: signUpUser,
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

  Future<void> signUpUser() async {
    if (_form.invalid) return;

    final user = User.fromJson(_form.value);

    final res = await ref.read(firebaseAuthProvider).signUpUser(
          user: user,
          password: _passwordCtlr.value,
        );

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        elevation: 7.0,
        content: const Row(
          children: [
            Text('Enregistrement effectué'),
            Spacer(),
            Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
