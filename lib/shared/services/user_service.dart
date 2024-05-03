import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:soutenance_app/core/modele/user.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';
import 'package:soutenance_app/core/modele/user.dart' as model;


final userService = Provider.autoDispose((ref) => _UserService(ref));
FirebaseAuth get _auth => FirebaseAuth.instance;

class _UserService extends FirestoreService{
  final Ref _ref;

  _UserService(this._ref);
  @override
  String get collection => 'USER';

  Future<List<UserCreated>> get users async {
    try {
      final docs = await super.docs;

      return docs.map((item) => UserCreated.fromJson(item)).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<UserCreated> getUser(String id) async{
    try{
      final data= await super.getDoc(id);
       if(data == null) throw Exception("une erreur s'est produite");
         return UserCreated.fromJson(data);

    } catch(e){
          rethrow;
          }
  }


  Future<UserCreated> signUpUser({
    required model.User user,
    required String password,
    //required RoleUser role,
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

      final id =credential.user!.uid;
      final data = <String,dynamic>{
        ...user.toJson(),
        'id': id,
      };

      data.addAll(user.toJson());

      //     .read(firestoreProvider)
      //     .firestore
      //     .collection('users')
      //     .doc(credential.user!.uid)
      //     .set({
      //   'id': credential.user!.uid,
      //   ...user.toJson(),
      // });
      await super.post(id: id, data: data);
      return UserCreated.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }


  Future<void> deleteUser(String userId) async {
    try {
      await firestore.collection(collection).doc(userId).delete();
    } catch (e) {
      // Gérer l'erreur ou la relancer si nécessaire
      print('Erreur lors de la suppression de l\'utilisateur : $e');
      rethrow;
    }
  }

}