import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/core/service/authentification_service.dart';
import 'package:soutenance_app/screen/home/home.dart';
import 'package:soutenance_app/widgets/custom_text_field.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  late final FormGroup _format;
  late final FormControl _passwordCtlr;
  late final FormControl _newPasswordCtlr;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _passwordCtlr = FormControl<String>(
         validators: [Validators.required, Validators.minLength(8)]);
    _newPasswordCtlr = FormControl<String>(
         validators: [Validators.required, Validators.minLength(8)]);
    _format = fb.group({
      "oldPassword": _passwordCtlr,
      "newPassword": _newPasswordCtlr,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,

      body: Center(
        child: SingleChildScrollView(
          child: ReactiveForm(
            formGroup: _format,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    'Modifier le mot de passe',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 29.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 20.0),
                  child: SizedBox(
                    width: 280.0,
                    child: Text(
                      "Pour éviter d'éventuelle risques, vous devez entrer votre ancien mot de passe et le nouveau mot de passe, afin d'utiliser un mot de passe différent du standard",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                    width: 200.0,
                    child: CustomTextField(
                      formControlName: 'oldPassword',
                      label: "Ancien mot de passe",
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                    width: 200.0,
                    child: CustomTextField(
                      formControlName: 'newPassword',
                      obscureText: true,
                      label: "nouveau mot de passe",
                      inputType: TextInputType.name,
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                InkWell(
                  onTap: () {},
                  child: ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mot de passe modifié'),
                        ),
                      );
                      ref.read(firebaseAuthProvider).changedPassword(
                          email: user!.email,
                          oldPassword: _passwordCtlr.value,
                          newPassword: _newPasswordCtlr.value);
                      // newPassword(docID: firestoreService.user.id);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: const Text('Connexion'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

