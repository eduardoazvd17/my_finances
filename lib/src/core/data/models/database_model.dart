import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseModel {
  final FirebaseFirestore _firestore;
  final CredentialsManager _credentialsManager;
  DatabaseModel({
    required FirebaseFirestore firestore,
    required CredentialsManager credentialsManager,
  })  : _firestore = firestore,
        _credentialsManager = credentialsManager;

  Future<SharedPreferences> get sharedPreferences {
    return SharedPreferences.getInstance();
  }

  CollectionReference<Map<String, dynamic>> get usersCollection {
    return _firestore.collection('users');
  }
}
