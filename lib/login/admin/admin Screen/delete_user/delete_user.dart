
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/shared/services/user_service.dart';

import '../../../../core/modele/user.dart';


class DeleteUser extends ConsumerStatefulWidget {
  const DeleteUser({super.key});

  @override
  ConsumerState createState() => _DeleteUserState();
}

class _DeleteUserState extends ConsumerState<DeleteUser> {

  Future delete(UserCreated user) async {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final docRef = userCollection.doc(user.id).delete();

  }


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
                onPressed: () async {

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
