import 'package:flutter/material.dart';

import '../login/users/login_screen.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({
    super.key,
  });

  @override
  State<AcceuilPage> createState() => _HomeScreen();
}

class _HomeScreen extends State<AcceuilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            const CircleAvatar(
              radius: 85.0,
              backgroundImage: AssetImage(
                'images/dgtt2.png',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: const Column(
                children: [
                  Text("Bienvenu sur Authentics",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 24.0,
                          color: Colors.black)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Text(
                        "l'application qui vous aide à controler les permis et les carte grise des usagers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: const ButtonStyle(
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));

              },
              child: const Text('Se connecter'),
            ),

          ],
        ),
      ),
    );
  }
}
