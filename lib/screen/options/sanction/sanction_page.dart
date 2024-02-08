import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/modele/sanctions/sanctions.dart';
import 'add_sanction.dart';

class SanctionPage extends StatelessWidget {
  Stream<List<Sanctions>> readJudge() {
    try {
      final res = FirebaseFirestore.instance
          .collection('jugement')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((duc) => Sanctions.fromJson(duc.data()))
              .toList());
      return res;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Widget buildJudge(Sanctions judge) => ListTile(
        title: Text(judge.matriculation),
        //subtitle: Text(jugement.sanctions as String),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Sanctions'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("DRIVERS").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final errorMessage = snapshot.error;
            return Center(
              child: Text(errorMessage.toString()),
            );
          } else if (snapshot.hasData) {
            final juge = snapshot.data!;
            final List<dynamic> sanctions = [];
            snapshot.data!.docs.forEach((element) {
              sanctions.add(element);
            });
            return InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Column(
                          children: [
                            Center(
                              child: Text(
                                "FICHE DE CONTROLE",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 15.0,
                            ),

                            Text(
                              "controle fait par l'agent :  242",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),

                            Text(
                              "nom permis",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            
                            Text(
                              "prenom permis",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),

                            Text(
                              "date de controle",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: ListView.builder(
                  itemCount: sanctions.length,
                  itemBuilder: (context, index) {
                    final sanctionList = sanctions[index];
                    final sanction = sanctionList['firstname'];
                    final sanctionner = sanctionList['profession'];
                    return ListTile(
                      title: Text("$sanction"),
                      subtitle: Text("$sanctionner"),
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      /*StreamBuilder<List<Sanctions>>(
        stream: readJudge(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final errorMessage = snapshot.error;
            return Center(
                child: Text(errorMessage.toString()),
            );
          } else if (snapshot.hasData) {
            final juge = snapshot.data!;
            return ListView(
              children: juge.map(buildJudge).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddSanctionDialog(),
          );
        },
      ),
    );
  }
}
