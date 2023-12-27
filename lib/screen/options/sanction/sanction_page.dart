
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
      body: StreamBuilder<List<Sanctions>>(
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
      ),
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
