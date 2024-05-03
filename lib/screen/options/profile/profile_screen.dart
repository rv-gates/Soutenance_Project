import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/modele/user.dart';
import '../../acceuil_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  final currentUsers = FirebaseAuth.instance.currentUser;

  Future<void> getUtilisateur() async {
    String userId = 'B8QWdPkDXEOBuobbkDsmIohMt4m2';

    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('USER')
        .doc(currentUsers!.uid)
        .get();
    if (document.exists) {
      Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

      String nom = userData['lastName'];
      String prenom = userData['firstName'];
      String matricule = userData['matricule'];
      String identifiant = userData['email'];
      String phoneNumber = userData['phoneNumber'];
    } else {
      print("Aucun document trouvé pour cet utilisateur");
    }
  }

  /*changePassword(email, oldPassword, newPassword) async{

    try{
  var cred = EmailAuthProvider.credential(email: email, password: oldPassword);

  await currentUser!.reauthenticateWithCredential(cred).then((value) {
  currentUser!.updatePassword(newPassword);
  });
    }catch(e){
      print(e.toString());
    }
  }*/
  @override
  void initState() {
    // TODO: implement initState
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Profil'),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white70,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("images/policeMan.jpg"),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('USER')
                  .doc(currentUsers!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text(
                        'Une erreur s\'est produite : ${snapshot.error}');
                  } else {
                    Map<String, dynamic> userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    String nom = userData['firstName'];
                    String prenom = userData['lastName'];
                    String matricule = userData['matricule'];
                    String identifiant = userData['email'];
                    String phoneNumber = userData['phoneNumber'];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 13),
                        const Center(
                            child: SizedBox(
                                width: 150.0,
                                child: Divider(
                                  height: 3.0,
                                  color: Colors.black,
                                ))),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                "Nom : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  nom,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                "Prénom : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  prenom,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                "Matricule :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  matricule,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                "Identifiant :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  identifiant,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0, bottom: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                "Téléphone :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  phoneNumber,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "DECONNEXION",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
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
                              Future.delayed(const Duration(seconds: 7), () {
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
                            child: const Text("Déconnexion"))
                      ],
                    );
                  }
                }
              },
            ),
          ),

          /*Center(
    child: CircleAvatar(
    radius: 60.0,
    backgroundImage: AssetImage("images/policeMan.jpg"),
    ),
    ),
    SizedBox(height: 18),

    Center(child: SizedBox(width:150.0,child: Divider(height: 3.0, color: Colors.black,))),

    SizedBox(height: 15),
    Padding(
    padding: EdgeInsets.all(18.0),
    child: Row(
    children: [
    Text(
    "Nom :",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    ),
    Padding(
    padding: EdgeInsets.only(left: 12.0),
    child: Text("", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
    )
    ],
    ),
    ),

    Padding(
    padding: EdgeInsets.all(18.0),
    child: Row(
    children: [
    Text(
    "Matricule :",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    ),
    Padding(
    padding: EdgeInsets.only(left: 12.0),
    child: Text("", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
    )
    ],
    ),
    ),

    Padding(
    padding: EdgeInsets.all(15.0),
    child: Row(
    children: [
    Text(
    "Téléphone :",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    ),
    Padding(
    padding: EdgeInsets.only(left: 12.0),
    child: Text("06 960 45 32", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
    )
    ],
    ),
    ),*/
        ],
      ),
    );
  }
}
