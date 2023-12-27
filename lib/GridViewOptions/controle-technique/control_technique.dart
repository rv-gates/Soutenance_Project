/*import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';

class ControleTechnique extends StatefulWidget {
  @override
  State<ControleTechnique> createState() => ControleTechniqueState();
}

late TextEditingController imController;
late TextEditingController marqueController;

class ControleTechniqueState extends State<ControleTechnique> {

  @override
  void initState() {
    imController = TextEditingController();
    marqueController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vérification contrôle technique',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                image: const DecorationImage(
                  image: AssetImage(
                    'images/secirity.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Veuillez saisir les informations suivantes :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextPlace(
                controller: imController,
                labelText: "Numéro d\'immatriculation",
                obscureText: false,
                textInputType: TextInputType.text),
            const SizedBox(height: 16.0),
            TextPlace(
                controller: marqueController,
                labelText: "Marque de voiture",
                obscureText: false,
                textInputType: TextInputType.text),
            const SizedBox(height: 14.0),
            SizedBox(
              width: 100.0,
              child: ElevatedButton(
                style: const ButtonStyle(),
                onPressed: () {},
                child: const Text('se connecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/