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
}
