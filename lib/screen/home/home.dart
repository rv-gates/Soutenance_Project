import 'package:flutter/material.dart';
import 'package:soutenance_app/GridViewOptions/authentification-permis/scan_page.dart';
import 'package:soutenance_app/GridViewOptions/verification_carte_grise/verification_carte_grise.dart';
import '../../widgets/verification_card.dart';
import '../options/addSomething/data_management.dart';
import '../options/profile/profile_screen.dart';
import '../options/sanction/sanction_page.dart';
import 'firebase_qr_code.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 35.0,
        backgroundColor: Colors.blueGrey,
        leading: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'images/dgtt2.png',
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Authentics',
            style: TextStyle(
                fontSize: 32.0,
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ProfileScreen()));
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
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text('Deconnexion'),
              ),
            ],
            onSelected: (value) {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
              child: Text(
                'Bienvenue sur Authentics',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 68.0, right: 38.0),
              child: Text(
                'Veuillez faire le choix de ce que vous voulez vérifier',
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
                    child:  const Card(
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
                          builder: (context) => VerificationCarteGrise()));
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
    );
  }
}
