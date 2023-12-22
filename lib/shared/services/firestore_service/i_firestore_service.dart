abstract interface class IFirestoreService {
  Future<void> addDocument({required String path, required Map<String, dynamic> data});
  Future<void> deleteDocument({required String path,required String id});
  Future<void> updateDocument({required String path, required Map<String, dynamic> data});
}
