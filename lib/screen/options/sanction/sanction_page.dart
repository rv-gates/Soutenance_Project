import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/control_document/control_document.dart';
import 'package:soutenance_app/core/modele/sanction/sanction.dart';
import 'package:soutenance_app/core/modele/user.dart';
import 'package:soutenance_app/shared/services/drivers_service.dart';
import 'package:soutenance_app/shared/services/sanction_service.dart';
import 'package:soutenance_app/shared/services/user_service.dart';
import '../../../core/modele/sanctions/sanctions.dart';
import '../../../shared/services/control_document_service.dart';

class SanctionPage extends ConsumerWidget {
  const SanctionPage({super.key});

  Widget buildJudge(Sanctions judge) => ListTile(
        title: Text(judge.matriculation),
        //subtitle: Text(jugement.sanctions as String),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Sanctions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<ControlDocumentCreated>>(
            future: ref.read(controlService).controlDocuments,
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final controlDocs = snapshot.data!;

                return ListView.separated(
                  separatorBuilder: (_, index) => const Divider(
                    thickness: 2,
                  ),
                  itemCount: controlDocs.length,
                  itemBuilder: (_, index) {
                    final doc = controlDocs[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Center(child: Text("FICHE CONTROLE", style: TextStyle(fontSize: 18.0),)),
                            content: ListTile(
                              title: FutureBuilder<UserCreated>(
                                  future:
                                  ref.read(userService).getUser(doc.idDriver),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final user = snapshot.data!;
                                      //final result = ref.read(driversService).getUser(doc.idConduct);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("controle éffectué par : ", style: TextStyle(fontSize: 14.0),),
                                          const SizedBox(height: 3.0),
                                          Center(child: Text(user.matricule, style: const TextStyle(color: Colors.redAccent))),
                                          const SizedBox(height: 7.0),
                                          const Center(child: Text("la sanction est :", style: TextStyle(fontSize: 14.0))),
                                          Text(doc.sanction.sanction, style: TextStyle(color: Colors.redAccent)),
                                        ],
                                      );
                                    }

                                    return const CircularProgressIndicator();
                                  }),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(doc.sanction.sanction),
                        subtitle: Row(
                          children: [
                            Text("Controle éffectué le "),
                            Text(doc.date.day.toString(), style: TextStyle(color: Colors.redAccent),),
                            Text("/", style: TextStyle(color: Colors.redAccent),),
                            Text(doc.date.month.toString(), style: TextStyle(color: Colors.redAccent),),
                            Text("/", style: TextStyle(color: Colors.redAccent),),
                            Text(doc.date.year.toString(), style: TextStyle(color: Colors.redAccent),),



                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
