import 'package:cloud_firestore/cloud_firestore.dart';

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
}
