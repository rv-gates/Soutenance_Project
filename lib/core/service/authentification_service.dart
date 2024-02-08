
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:soutenance_app/core/modele/user.dart' as model;
import 'package:soutenance_app/shared/services/user_service.dart';

import 'firestore_service.dart';

final firebaseAuthProvider = Provider((ref) => AuthentificationService(ref));

class AuthentificationService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  final ProviderRef _ref;

  AuthentificationService(this._ref);

  Future<model.User> signUpUser({
    required model.User user,
    required String password,
  }) async {
    try {
      if (user.email.isEmpty && user.email.isEmail()) {
        throw Exception('email invalid');
      }

      if (password.isEmpty && password.length < 6) {
        throw Exception('password length must be >= 6');
      }

      if (user.firstName.isEmpty || user.lastName.isEmpty) {
        throw Exception('firstName or lastName must not be empty');
      }

      if (user.matricule.isEmpty) throw Exception('username must not be empty');

      // todo verifier si l'username est déja present dans la BD

      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);

      final data = <String,dynamic>{
        'id': credential.user!.uid,
      };

      data.addAll(user.toJson());

       await _ref.read(userService).users;
      //     .read(firestoreProvider)
      //     .firestore
      //     .collection('users')
      //     .doc(credential.user!.uid)
      //     .set({
      //   'id': credential.user!.uid,
      //   ...user.toJson(),
      // });
      return user;
    } catch (_) {
      rethrow;
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    print('Utilisateur déconnecté');
  }

  void changedPassword({required email, required oldPassword,required newPassword}) async{
    try {
      var cred = EmailAuthProvider.credential(email: email, password: oldPassword);
      var currentUser= FirebaseAuth.instance.currentUser;
      await currentUser!.reauthenticateWithCredential(cred).then((value) => {
        currentUser.updatePassword(newPassword),
      }/*).catchError((e)*/ );

    }catch(e) {
      print(e.toString());
    }
    }

  Future<void> loginUser({
    required String password,
    required String email,
  }) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print("Login success");
      }
    } catch (error) {
      print(error.toString());
    }
  }
  }

