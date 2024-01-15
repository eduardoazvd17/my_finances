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

  DocumentReference<Map<String, dynamic>> userDataCollection(String userId) {
    return _firestore.collection('finances').doc(userId);
  }

  Reference userProfilePictureStorageReference(String userId) {
    return _storage.ref('profile_pictures/$userId');
  }
}
