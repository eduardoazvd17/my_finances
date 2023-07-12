import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../models/document_model.dart';

class DocumentEditorService {
  final DatabaseModel _database;

  DocumentEditorService({
    required DatabaseModel database,
  }) : _database = database;

  Future<void> loadData(DocumentModel documentModel) async {
    try {
      //TODO: Carregar dados salvos.
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
