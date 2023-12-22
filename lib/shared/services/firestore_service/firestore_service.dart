import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/shared/services/firestore_service/i_firestore_service.dart';

final firestoreServiceProvider =
    Provider<IFirestoreService>((ref) => FirestoreService());

final class FirestoreService implements IFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addDocument(
      {required String path, required Map<String, dynamic> data}) async {
    final DocumentReference documentReference =
        _firestore.collection(path).doc(data['id'].toString());
    await documentReference.set(data);
  }

  @override
  Future<void> deleteDocument({required String path,required String id}) async {
    final DocumentReference documentReference = _firestore.collection(path).doc(id);
    await documentReference.delete();
  }

  @override
  Future<void> updateDocument(
      {required String path, required Map<String, dynamic> data}) async {
    final DocumentReference documentReference =
        _firestore.collection('notes').doc(data['id'].toString());
    await documentReference.update(data);
  }
}
