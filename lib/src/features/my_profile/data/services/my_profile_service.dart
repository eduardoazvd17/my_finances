import '../../../../core/data/models/database_model.dart';

class MyProfileService {
  final DatabaseModel _database;

  MyProfileService({
    required DatabaseModel database,
  }) : _database = database;
}
