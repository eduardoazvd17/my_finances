import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseModel {
  final CredentialsManager credentialsManager;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  DatabaseModel({
    required this.credentialsManager,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage;

  Future<SharedPreferences> get sharedPreferences {
    return SharedPreferences.getInstance();
  }

  CollectionReference<Map<String, dynamic>> get usersCollection {
    return _firestore.collection('users');
  }

  CollectionReference<Map<String, dynamic>> get documentsCollection {
    return _firestore.collection('documents');
  }

  CollectionReference<Map<String, dynamic>> documentGroupsCollection(
    String documentId,
  ) {
    return documentsCollection.doc(documentId).collection('groups');
  }

  CollectionReference<Map<String, dynamic>> documentItemsCollection(
    String documentId,
  ) {
    return documentsCollection.doc(documentId).collection('items');
  }

  Reference userProfilePictureStorageReference(String userId) {
    return _storage.ref('profile_pictures/$userId');
  }
}
