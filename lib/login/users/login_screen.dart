import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screen/acceuil_page.dart';
import '../../screen/home/home.dart';
import '../../widgets/custom_text_field.dart';
import '../admin/admin Screen/admin_screen.dart';
import '../forgot_password/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final FormGroup forms;
  int loginAttempts = 0;
  bool _showForgotPasswordPage = false;
  bool isConnect = true;
  bool isLoading = true;

  void loginError() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
          title: Text(
        "Mot de passe Incorrect",
        style: TextStyle(fontSize: 15.0),
      )),
    );
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();

    forms = fb.group({
      "email": FormControl(validators: [Validators.required, Validators.email]),
      "password": FormControl(
          validators: [Validators.required, Validators.minLength(8)])
    });
    _pageVerification();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnect) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Erreur de connexion',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Veuillez vérifier votre connexion Internet 🤖🥲',
                  style: TextStyle(fontSize: 11.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("retour")),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
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
                      'connexion',
                      style: TextStyle(
                          fontSize: 33.0,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
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
                        obscureText: true,
                        formControlName: "password",
                        label: "mot de passe",
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 120.0,
                      height: 33.0,
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            if (forms.controls['email']!.value.toString() == ""){
                             print("Nothing");
                            } else{
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CONNEXION",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 13.0,
                                        ),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                },
                              );
                              Future.delayed(const Duration(seconds: 5), () {
                                Navigator.of(context, rootNavigator: true).pop();
                              });
                            }
                            signIn(forms.controls['email']!.value.toString(),
                                forms.controls['password']!.value.toString());
                          } catch (e) {
                            rethrow;
                          }
                        },
                        child: const Text("Connexion"),
                      ),
                    ),

                    const SizedBox(
                      height: 40.0,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _pageVerification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _showForgotPasswordPage = pref.getBool('pageAffichee') ?? false;

    if (!_showForgotPasswordPage) {
      _showForgotPasswordPage = true;
      await pref.setBool('pageAffichee', true);
    }
  }

  void route() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('USER')
          .doc(user.uid)
          .get();

      if (!snapshot.exists) {
        print('Document does not exist on the database');
        loginError();
      }

      if (!mounted) return;

      if (snapshot.get('role') == "administrateur") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminScreen(),
          ),
              (route) => false,
        );
      } else {
        if (forms.controls['password']!.value == "12341234") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPassword(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  void signIn(String email, String password) async {
    if (forms.invalid) return;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      const Column(
        children: [
          Text("connexion"),
          SizedBox(
            height: 10.0,
          ),
          CircularProgressIndicator(),
        ],
      );
      route();
      loginAttempts = 0;
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe incorrect. Veuillez réessayer.'),
          ),
        );
      }
      loginAttempts++;
      if (loginAttempts >= 3) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nombre de tentatives dépassées",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                )
              ],
            ),
            content: TextButton(
                onPressed: () {
                  showDialog(
                    barrierColor: Colors.blueGrey,
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Redémarrage en cours",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    },
                  );
                  Future.delayed(const Duration(seconds: 5), () {
                    Navigator.of(context, rootNavigator: true).pop();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcceuilPage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                child: const Text("Redémarrer")),
          ),
        );
      }
    }
    /*on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }*/
  }
}
