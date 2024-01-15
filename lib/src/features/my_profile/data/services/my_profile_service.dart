import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/data/models/user_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';

class MyProfileService {
  final DatabaseModel _database;

  MyProfileService({
    required DatabaseModel database,
  }) : _database = database;

  Future<bool> changeUserName({
    required String userId,
    required String newName,
  }) async {
    try {
      await _database.usersCollection.doc(userId).update({'name': newName});
      return true;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<String?> changeUserProfilePicture({
    required Uint8List? fileBytes,
    required String userId,
    required String? currentUserPhotoUrl,
  }) async {
    try {
      final Reference storageReference =
          _database.userProfilePictureStorageReference(userId);

      final String? url;
      if (fileBytes == null) {
        await storageReference.delete();
        url = null;
      } else {
        await storageReference.putData(fileBytes);
        url = await storageReference.getDownloadURL();
      }

      if (currentUserPhotoUrl != url) {
        await _database.usersCollection.doc(userId).update({'photoUrl': url});
      }
      return url;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<bool> changeUserNickname({
    required String userId,
    required String? newNickname,
  }) async {
    try {
      await _database.usersCollection
          .doc(userId)
          .update({'nickname': newNickname});
      return true;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<bool> changeUserPassword({
    required String userId,
    required String? newPassword,
  }) async {
    try {
      await _database.usersCollection
          .doc(userId)
          .update({'password': newPassword});
      return true;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<bool> deleteAccount({required String userId}) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      await _database.userDataCollection(userId).delete();
      await _database.usersCollection.doc(userId).delete();
      await batch.commit();

      try {
        await _database.userProfilePictureStorageReference(userId).delete();
      } catch (_) {}

      return true;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> updateSavedCredentials(UserModel userModel) async {
    if (kIsWeb) {
      final prefs = await _database.sharedPreferences;
      prefs.setString('LoggedUserID', userModel.id);
      prefs.setString('LoggedUserPasswordHash', userModel.password);
    } else {
      await _database.credentialsManager.removeAllCredentials();
      await _database.credentialsManager.saveCredential(
        CredentialModel(
          id: userModel.id,
          loginOrEmail: userModel.email,
          password: userModel.password,
          name: userModel.name,
        ),
      );
    }
  }
}
