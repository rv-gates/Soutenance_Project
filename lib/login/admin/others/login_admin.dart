import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:soutenance_app/login/admin/drawer/drawer_screen.dart';
import 'package:soutenance_app/widgets/custom_text_field.dart';

import '../admin Screen/admin_screen.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController bioController;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    bioController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: Text(
                  'Connexion \nAdministrateur',
                  style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 58.0, right: 20.0),
                child: SizedBox(
                  width: 280.0,
                  child: Text(
                    "l'administrateur doit s'authentifier pour pouvoir gérer les problèmes rencontré par l'utilisateur",
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
              SizedBox(
                  width: 200.0,
                  child: CustomTextField(
                    //controller: userNameController,
                    label: "nom",
                    obscureText: false,
                    inputType: TextInputType.text,
                  )),
              const SizedBox(
                height: 7.0,
              ),
              SizedBox(
                  width: 200.0,
                  child: CustomTextField(
                    //controller: emailController,
                    label: "prenom",
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  )),
              const SizedBox(
                height: 7.0,
              ),
              SizedBox(
                  width: 200.0,
                  child: CustomTextField(
                    //controller: passwordController,
                    obscureText: true,
                    label: "mot de passe",
                    inputType: TextInputType.name,
                  )),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                style: const ButtonStyle(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminScreen(),
                  ));
                },
                child: const Text('Connexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
