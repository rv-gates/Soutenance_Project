import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  String get collection;

  Future<List<Map<String, dynamic>>> get docs async {
    try {
      final snapshots = await firestore.collection(collection).get();

      return snapshots.docs.map((item) => item.data()).toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getDoc(String id) async {
    final doc = await firestore.collection(collection).doc(id).get();
    return doc.data();
  }

  Future<void> post({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(collection).doc(id).set(data);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<dynamic>> query(String field,
      {Object? isEqualTo,
      Object? isNotEqualTo,
      Object? isLessThan,
      Object? isLessThanOrEqualTo,
      Object? isGreaterThan,
      Object? isGreaterThanOrEqualTo,
      Object? arrayContains,
      Iterable<Object?>? arrayContainsAny,
      Iterable<Object?>? whereIn,
      Iterable<Object?>? whereNotIn,
      bool? isNull}) async {
    final snapshot = await firestore
        .collection(collection)
        .where(field,
            isEqualTo: isEqualTo,
            arrayContains: arrayContains,
            arrayContainsAny: arrayContainsAny,
            isGreaterThan: isGreaterThan,
            isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
            isLessThan: isLessThan,
            isLessThanOrEqualTo: isLessThanOrEqualTo,
            isNotEqualTo: isNotEqualTo,
            isNull: isNull)
        .get();

    return snapshot.docs.map((e) => e.data()).toList(growable: false);
  }
}
