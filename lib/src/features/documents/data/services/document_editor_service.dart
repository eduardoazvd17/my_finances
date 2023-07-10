import '../../../../core/data/models/database_model.dart';
import '../../../../core/data/models/user_model.dart';

class DocumentEditorService {
  final UserModel userModel;
  final DatabaseModel _database;

  DocumentEditorService({
    required this.userModel,
    required DatabaseModel database,
  }) : _database = database;
}
