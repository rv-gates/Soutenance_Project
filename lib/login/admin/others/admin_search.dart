import 'package:flutter/material.dart';

import '../../../core/modele/user.dart';
import '../../../widgets/custom_text_field.dart';

class AdminSearch extends StatefulWidget {
  const AdminSearch({super.key});

  @override
  State<AdminSearch> createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  late TextEditingController searchController;
  List<User> users = [];

  void searchUsers(String searchText) {
    final filteredUsers = users.where((user) {
      final username = user.lastName.toLowerCase();
      final searchLower = searchText.toLowerCase();
      return username.contains(searchLower);
    }).toList();
  }

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Text(
        'Ajouter une sanction',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            SingleChildScrollView(
              child: /*TextPlace(
                    controller: searchController,
                    obscureText: false,
                    labelText: "rechercher un utilisateur",
                    textInputType:
                    TextInputType.text,
                  ),
                ),
              ],
            ),*/
                  TextField(
                onChanged: (value) {
                  // Appeler une fonction pour filtrer les utilisateurs en fonction du texte saisi
                  searchUsers(value);
                },
                decoration: InputDecoration(
                  labelText: 'Rechercher un utilisateur',
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: ElevatedButton(
                child: const Text(
                  'Ajouter',
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
