import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soutenance_app/widgets/utils.dart';

import '../../../core/modele/sanction/sanction.dart';

class SanctionListPage extends StatefulWidget {
  @override
  _SanctionListPageState createState() => _SanctionListPageState();
}

class _SanctionListPageState extends State<SanctionListPage> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _sanctionStream =
  FirebaseFirestore.instance.collection('SANCTION').snapshots();


  Future<void> deleteSanction(String sanctionId) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('SANCTION').doc(sanctionId).delete();

    docRef;
    Utils.showSnackBar(context, 'Sanction suprimée');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des sanctions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _sanctionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final sanctions = snapshot.data!.docs.map((doc) =>
                      SanctionCreated.fromJson(doc.data())).toList();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: sanctions.length,
                        itemBuilder: (context, index) {
                          final sanction = sanctions[index];
                          return Card(
                            shadowColor: Colors.blueGrey,
                            elevation: 5.0,
                            child: ListTile(
                              title: Text(sanction.sanction),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await deleteSanction(sanction.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}



