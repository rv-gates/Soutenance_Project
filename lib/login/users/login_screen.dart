import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:soutenance_app/screen/acceuil_page.dart';
import '../../../screen/home/home.dart';
import '../../../widgets/custom_text_field.dart';
import '../admin/admin Screen/admin_screen.dart';
import '../forgot_password/forgot_password.dart';
import '../admin/others/login_admin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  late final FormGroup forms;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();

    forms = fb.group({
      "email": FormControl<String>(
          value: '', validators: [Validators.required, Validators.email]),
      "password": FormControl<String>(
          value: '', validators: [Validators.required, Validators.minLength(8)])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height /1.2,
            width: MediaQuery.of(context).size.width / 1.2,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ReactiveForm(
              formGroup: forms,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),
                  const CircleAvatar(
                    radius: 27.0,
                    backgroundImage: AssetImage(
                      'images/cadena.png',
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Connexion',
                    style: TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Stack(
                    children: [],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  /*
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "email",
                      label: "identifiant",
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CustomTextField(
                      formControlName: "password",
                      label: "mot de passe",
                    ),
                  ),*/
                  SizedBox(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(

                        controller: emailController,
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      width: 220.0,
                      height: 40.0,
                      child: TextField(
                        controller: passwordController,
                      )),
                  const SizedBox(
                    height: 15.0,
                  ),

                  SizedBox(
                    width: 150.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if(emailController.text =="admin" && passwordController.text == "admin"){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminScreen()));
                        }else{
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const ForgotPassword()));
                        }
                      },
                      child: const Text("Connexion"),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Spacer(),
                  /*Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: InkWell(
                      onTap: () {

                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          text: 'Cliquez ici si vous etes ',
                          children: [
                            TextSpan(text: ' '),
                            TextSpan(
                                text: 'Administrateur',
                                style: TextStyle(color: Colors.deepPurple)),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var routeData = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AdminScreen(),
            ),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AcceuilPage(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }*/
}
