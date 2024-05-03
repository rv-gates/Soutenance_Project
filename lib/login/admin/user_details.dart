import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/modele/user.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

void showUserDetailsDialog(BuildContext context, Map<String, dynamic> userData) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Détails de l\'utilisateur'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nom: ${userData['nom']}'),
            Text('Prénom: ${userData['prenom']}'),
            Text('Matricule: ${userData['matricule']}'),
            // Ajoutez d'autres champs si nécessaire
          ],
        ),
      );
    },
  );
}

class _UserDetailsState extends State<UserDetails> {
  Future<List<Map<String, dynamic>>> getUsersData() async {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('USER').get();
    List<Map<String, dynamic>> usersList = [];

    for (var doc in usersSnapshot.docs) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      usersList.add(userData);
    }

    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();

    /*SingleChildScrollView(
      child: AlertDialog(
        title: Column(
          children: [
            const Center(
              child: Text(
                "FICHE AGENT",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getUsersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erreur de chargement des données');
                } else {
                  List<Map<String, dynamic>> users = snapshot.data!;
                  return Column(
                    children: users.map((userData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Nom :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    userData['firstName'] ?? 'N/A',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Prénom :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    userData['lastName'] ?? 'N/A',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                const Text(
                                  "matricule :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    userData['matricule'] ?? 'N/A',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),

            /*Center(
              child: Text(
                "FICHE AGENT",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Nom :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.0),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w400,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Prénom :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.0),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w400,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
              EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Identifiant :",
                    style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(
                        left: 12.0),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w400,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Matricule :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.0),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w400,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );*/
  }
}
