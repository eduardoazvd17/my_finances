import 'package:credentials_manager/credentials_manager.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';

class AuthService {
  final DatabaseModel database;

  AuthService({
    required this.database,
  });

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
