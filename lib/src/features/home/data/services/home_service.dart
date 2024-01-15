import '../../../../core/data/models/user_model.dart';

import '../../../../core/data/models/database_model.dart';

class HomeService {
  final UserModel userModel;
  final DatabaseModel _database;

  HomeService({
    required this.userModel,
    required DatabaseModel database,
  }) : _database = database;
}
