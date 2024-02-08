import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/driver/driver.dart';
import 'package:soutenance_app/core/service/authentification_service.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/shared/services/user_service.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/modele/user.dart';


class DeleteUser extends ConsumerStatefulWidget {
  const DeleteUser({super.key});

  @override
  ConsumerState createState() => _DeleteUserState();
}

class _DeleteUserState extends ConsumerState<DeleteUser> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Voulez vous vraiment supprimer cet utilisateur ?',
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
                onPressed: () async{
                  // final collection = ref.read(firestoreProvider).firestore.collection('users');
                  // collection
                  //     .doc('') // <-- Doc ID to be deleted.
                  //     .delete() // <-- Delete
                  //     .then((_) => print('Deleted'))
                  //     .catchError((error) => print('Delete failed: $error'));
                  // Navigator.pop(context);
                  final UserCreated? user;
                  await ref.read(userService).deleteUser("");
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
