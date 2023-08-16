import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';

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
    required File? file,
    required String userId,
  }) async {
    try {
      final Reference storageReference =
          _database.userProfilePictureStorageReference(userId);

      final String? url;
      if (file == null) {
        await storageReference.delete();
        url = null;
      } else {
        await storageReference.putFile(file);
        url = await storageReference.getDownloadURL();
      }

      await _database.usersCollection.doc(userId).update({'photoUrl': url});
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
      final documentsQuery = await _database.documentsCollection
          .where('ownerId', isEqualTo: userId)
          .get();
      for (final doc in documentsQuery.docs) {
        batch.delete(doc.reference);

        /// Deleting all groups
        final groupsQuery =
            await _database.documentGroupsCollection(doc.id).get();
        if (groupsQuery.docs.isNotEmpty) {
          for (final group in groupsQuery.docs) {
            batch.delete(group.reference);
          }
        }

        /// Deleting all items
        final itemsQuery =
            await _database.documentItemsCollection(doc.id).get();
        if (itemsQuery.docs.isNotEmpty) {
          for (final item in itemsQuery.docs) {
            batch.delete(item.reference);
          }
        }
      }
      await batch.commit();
      await _database.usersCollection.doc(userId).delete();
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
