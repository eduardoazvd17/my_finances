import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseModel {
  final CredentialsManager credentialsManager;
  final FirebaseFirestore _firestore;
  DatabaseModel({
    required this.credentialsManager,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<SharedPreferences> get sharedPreferences {
    return SharedPreferences.getInstance();
  }

  CollectionReference<Map<String, dynamic>> get usersCollection {
    return _firestore.collection('users');
  }
}
