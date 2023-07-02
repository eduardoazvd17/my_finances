import 'package:credentials_manager/credentials_manager.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences localDatabase;
  AuthService({required this.localDatabase});

  Future<UserModel> login(CredentialModel credential) async {
    return UserModel(
      id: 'id',
      name: credential.name!,
      email: credential.loginOrEmail,
    );
  }

  Future<UserModel> register(CredentialModel credential) async {
    return UserModel(
      id: 'id',
      name: credential.name!,
      email: credential.loginOrEmail,
    );
  }
}
