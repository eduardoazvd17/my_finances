import 'dart:convert';

import 'package:credentials_manager/credentials_manager.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../../../../core/data/models/user_model.dart';

import '../../../../core/data/enums/app_language.dart';

class AuthService {
  final DatabaseModel _database;

  AuthService({
    required DatabaseModel database,
  }) : _database = database;

  Future<UserModel?> autoLogin() async {
    try {
      if (kIsWeb) {
        final prefs = await _database.sharedPreferences;
        final String? userId = prefs.getString('LoggedUserID');
        final String? password = prefs.getString('LoggedUserPasswordHash');
        if (userId != null) {
          return await checkIfUserExists(userId, password: password);
        }
      } else {
        final List<CredentialModel> credentials =
            await _database.credentialsManager.getSavedCredentials();
        if (credentials.isNotEmpty) {
          final CredentialModel credential = credentials.first;
          final UserModel userModel = UserModel(
            id: credential.id,
            name: credential.name!,
            email: credential.loginOrEmail,
            password: credential.password,
          );

          return await checkIfUserExists(
            userModel.id,
            password: userModel.password,
          );
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final query = await _database.usersCollection
          .where('email', isEqualTo: email)
          .get();
      if (query.docs.isNotEmpty && query.docs.first.exists) {
        final UserModel userModel = UserModel.fromMap(query.docs.first.data());
        if (userModel.password == _md5Hash(password)) {
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
          return userModel;
        } else {
          throw AppError(message: 'incorrect-password'.i18n());
        }
      }
      throw AppError(message: 'incorrect-email'.i18n());
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final query = await _database.usersCollection
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isNotEmpty && query.docs.first.exists) {
        throw AppError(message: 'user-exists'.i18n());
      } else {
        final dbRef = _database.usersCollection.doc();
        final UserModel userModel = UserModel(
          id: dbRef.id,
          name: name,
          email: email,
          password: _md5Hash(password),
        );
        await dbRef.set(userModel.toMap());
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
        return userModel;
      }
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<UserModel?> checkIfUserExists(String userId,
      {String? password}) async {
    final reference = await _database.usersCollection.doc(userId).get();
    if (reference.exists && reference.data() != null) {
      final userFromDb = UserModel.fromMap(reference.data()!);
      if (password == null || userFromDb.password == password) {
        return userFromDb;
      }
    }
    return null;
  }

  Future<void> logout() async {
    await _database.credentialsManager.removeAllCredentials();
    final prefs = await _database.sharedPreferences;
    await prefs.clear();
  }

  Future<bool> checkIfCanEnableBiometrics() async {
    if (kIsWeb) return false;
    return await _database.credentialsManager.canCheckBiometrics() &&
        await _database.credentialsManager.isDeviceSupportedByAuth();
  }

  Future<bool> checkIfBiometricsIsEnabled() async {
    if (kIsWeb) return false;
    final prefs = await _database.sharedPreferences;
    return prefs.getBool('isBiometricsEnabled') ?? false;
  }

  Future<bool> enableBiometrics() async {
    if (kIsWeb) return false;
    final result = await _database.credentialsManager.requestAuth(
      authReasonMessage: 'enable-biometrics-button'.i18n(),
    );
    if (result) {
      final prefs = await _database.sharedPreferences;
      prefs.setBool('isBiometricsEnabled', true);
    }
    return result;
  }

  Future<void> disableBiometrics() async {
    final prefs = await _database.sharedPreferences;
    prefs.setBool('isBiometricsEnabled', false);
  }

  Future<bool> requestAuth() async {
    if (kIsWeb) return true;
    return await _database.credentialsManager.requestAuth(
      authReasonMessage: 'auth-required-text'.i18n(),
    );
  }

  Future<void> saveUserLanguage({
    required UserModel userModel,
    required AppLanguage? appLanguage,
  }) async {
    try {
      final prefs = await _database.sharedPreferences;
      if (appLanguage != null) {
        prefs.setInt('AppLanguage-${userModel.id}', appLanguage.index);
      } else {
        prefs.remove('AppLanguage-${userModel.id}');
      }
    } catch (_) {}
  }

  Future<AppLanguage?> getUserLanguage({required UserModel userModel}) async {
    try {
      final prefs = await _database.sharedPreferences;
      final int? index = prefs.getInt('AppLanguage-${userModel.id}');
      return index != null ? AppLanguage.values[index] : null;
    } catch (_) {
      return null;
    }
  }

  String _md5Hash(String value) {
    return md5.convert(utf8.encode(value)).toString();
  }
}
