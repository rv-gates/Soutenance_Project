import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soutenance_app/GridViewOptions/authentification-permis/scan_page.dart';
import 'package:soutenance_app/GridViewOptions/verification_carte_grise/verification_carte_grise.dart';
import 'package:soutenance_app/screen/acceuil_page.dart';
import '../../core/modele/carte_grise/vehicle_document.dart';
import '../../core/modele/permis/driver_license.dart';
import '../../widgets/verification_card.dart';
import '../options/profile/profile_screen.dart';
import '../options/sanction/sanction_page.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
   VehicleDocumentCreated? driverLicenses;


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.blueGrey,
        leading: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'images/dgtt2.jpg',
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Authentics',
            style: TextStyle(
                fontSize: 29.0,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                    },
                    child: const Text('profile')),
              ),
              /*PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DataManagement()));
                    },
                    child: const Text('Historique')),
              ),*/
              PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SanctionPage()));
                    },
                    child: const Text('Liste sanctions')),
              ),
              PopupMenuItem(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("DECONNEXION", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w600),),
                            SizedBox(height: 13.0,),
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
                child: const Text('Deconnexion'),
              ),
            ],
            onSelected: (value) {},
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
                  child: Text(
                    'Bienvenue sur Authentics',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 58.0, right: 38.0),
                  child: Text(
                    'Veuillez faire le choix de ce que ',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 58.0, right: 38.0),
                  child: Text(
                    'vous voulez vérifier',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
                    mainAxisSpacing: 46.0,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScanPage()));
                        },
                        child: const Card(
                          color: Colors.white38,
                          elevation: 20.0,
                          child: VerificationCard(
                            title: 'Authentification permis',
                            icon: Icons.qr_code_2_outlined,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      /*InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ControleTechnique()));
                        },
                        child: const VerificationCard(
                          title: 'Vérification contrôle technique',
                          icon: Icons.car_repair,
                          color: Colors.green,
                        ),
                      ),*/
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VerificationCarteGrise(driverLicenses.toString())));
                        },
                        child: const Card(
                          color: Colors.white38,
                          elevation: 20.0,
                          child: VerificationCard(
                            title: "Vérification Carte Grise",
                            icon: Icons.car_crash_sharp,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
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
