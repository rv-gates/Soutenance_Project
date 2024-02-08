import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soutenance_app/core/modele/user.dart';
import 'package:soutenance_app/core/service/firestore_service.dart';

final userService = Provider.autoDispose((ref) => _UserService(ref));


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