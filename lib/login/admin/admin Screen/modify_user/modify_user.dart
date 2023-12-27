import 'package:flutter/material.dart';

class ModifyUser extends StatefulWidget {
  const ModifyUser({super.key});

  @override
  State<ModifyUser> createState() => _ModifyUserState();
}

class _ModifyUserState extends State<ModifyUser> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Modifier cet agent',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
              child: const Text(
                'Annuler',
                style: TextStyle(fontSize: 10.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 9.0,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  /*String? docId;
                              final docUser = FirebaseFirestore.instance.collection('users').doc(docId!);
                              docUser.delete();*/
                  Navigator.pop(context);
                },
                child: const Text(
                  'Supprimer',
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
