import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../models/document_model.dart';

class DocumentEditorService {
  final DatabaseModel _database;

  DocumentEditorService({
    required DatabaseModel database,
  }) : _database = database;

  Future<List<GroupingModel>> loadGroups(DocumentModel documentModel) async {
    try {
      //TODO: Carregar grupos salvos.
      return [];
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<List<ItemModel>> loadItems(DocumentModel documentModel) async {
    try {
      //TODO: Carregar items salvos.
      return [];
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
