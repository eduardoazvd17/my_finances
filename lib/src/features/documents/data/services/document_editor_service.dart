import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../enums/document_type.dart';
import '../models/document_model.dart';

class DocumentEditorService {
  final DatabaseModel _database;

  DocumentEditorService({
    required DatabaseModel database,
  }) : _database = database;

  Future<List<GroupingModel>> loadGroups(DocumentModel documentModel) async {
    try {
      final query =
          await _database.documentGroupsCollection(documentModel.id).get();

      return query.docs
          .map((doc) => GroupingModel.fromMap(doc.data()))
          .toList();
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<List<ItemModel>> loadItems(DocumentModel documentModel) async {
    try {
      final query =
          await _database.documentItemsCollection(documentModel.id).get();

      //TODO: Implementar outros tipos de itens.
      return switch (documentModel.type) {
        DocumentType.monthlyExpenseControl => [],
        DocumentType.investmentControl => [],
        DocumentType.annotation => query.docs
            .map((doc) => AnnotationItemModel.fromMap(doc.data()))
            .toList(),
        DocumentType.pointsAndAirlineMiles => [],
      };
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
