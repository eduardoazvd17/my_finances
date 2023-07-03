import 'dart:convert';

import 'package:credentials_manager/credentials_manager.dart';
import 'package:crypto/crypto.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/errors/app_error.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';

class AuthService {
  final DatabaseModel _database;

  AuthService({
    required DatabaseModel database,
  }) : _database = database;

  Future<UserModel?> autoLogin() async {
    try {
      final List<CredentialModel> credentials =
          await _database.credentialsManager.getSavedCredentials();
      if (credentials.isNotEmpty) {
        final CredentialModel credential = credentials.first;
        return UserModel(
          id: credential.id,
          name: credential.name!,
          email: credential.loginOrEmail,
          password: credential.password,
        );
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
          await _database.credentialsManager.removeAllCredentials();
          await _database.credentialsManager.saveCredential(
            CredentialModel(
              id: userModel.id,
              loginOrEmail: userModel.email,
              password: userModel.password,
              name: userModel.name,
            ),
          );
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
        await _database.credentialsManager.removeAllCredentials();
        await _database.credentialsManager.saveCredential(
          CredentialModel(
            id: userModel.id,
            loginOrEmail: userModel.email,
            password: userModel.password,
            name: userModel.name,
          ),
        );
        return userModel;
      }
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> logout() async {
    await _database.credentialsManager.removeAllCredentials();
    final prefs = await _database.sharedPreferences;
    await prefs.clear();
  }

  Future<bool> checkIfCanEnableBiometrics() async {
    return await _database.credentialsManager.canCheckBiometrics() &&
        await _database.credentialsManager.isDeviceSupportedByAuth();
  }

  Future<bool> checkIfBiometricsIsEnabled() async {
    final prefs = await _database.sharedPreferences;
    return prefs.getBool('isBiometricsEnabled') ?? false;
  }

  Future<bool> enableBiometrics() async {
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
    return await _database.credentialsManager.requestAuth(
      authReasonMessage: 'auth-required-text'.i18n(),
    );
  }

  String _md5Hash(String value) {
    return md5.convert(utf8.encode(value)).toString();
  }
}
