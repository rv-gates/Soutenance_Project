import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/modele/sanction/sanction.dart';
import '../utils.dart';

class ModifySanctionPage extends StatefulWidget {


  const ModifySanctionPage({Key? key,}) : super(key: key);

  @override
  _ModifySanctionPageState createState() => _ModifySanctionPageState();
}

class _ModifySanctionPageState extends State<ModifySanctionPage> {
  final _sanctionTextController = TextEditingController();
  SanctionCreated? sanctionToEdit;

  Future<void> updateSanction(SanctionCreated updatedSanction) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('sanctions').doc(updatedSanction.id); // Assuming 'sanctions' is your collection name

    await docRef.update({
      'sanction': updatedSanction.sanction, // Update the 'sanction' field
    });
  }

  @override
  void initState() {
    super.initState();
    _sanctionTextController.text = sanctionToEdit!.sanction; // Set initial text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la sanction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sanctionTextController,
              decoration: const InputDecoration(labelText: 'Sanction'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedSanction = SanctionCreated(
                  id: sanctionToEdit!.id, // Keep the original ID
                  sanction: _sanctionTextController.text,
                );

                // Update the sanction in your data source (e.g., Database service)
                await updateSanction(updatedSanction);

                Navigator.pop(context); // Go back to previous page
                Utils.showSnackBar(context, 'Sanction modifiée');
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}