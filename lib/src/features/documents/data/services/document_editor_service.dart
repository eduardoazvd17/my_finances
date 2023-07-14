import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../enums/document_type.dart';
import '../models/document_model.dart';

class DocumentEditorService {
  final DocumentModel documentModel;
  final DatabaseModel _database;

  DocumentEditorService({
    required this.documentModel,
    required DatabaseModel database,
  }) : _database = database;

  Future<List<GroupingModel>> loadGroups() async {
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

  Future<List<ItemModel>> loadItems() async {
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

  Future<GroupingModel> addGrouping({
    required String name,
    required bool initializeExpanded,
  }) async {
    try {
      final docRef = _database.documentGroupsCollection(documentModel.id).doc();
      final GroupingModel groupingModel = GroupingModel(
        id: docRef.id,
        name: name,
        initializeExpanded: initializeExpanded,
        creationDate: DateTime.now(),
      );
      await docRef.set(groupingModel.toMap());
      return groupingModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<GroupingModel> editGrouping({
    required GroupingModel groupingModel,
    String? newName,
    bool? newInitializeExpanded,
  }) async {
    if (newName == null && newInitializeExpanded == null ||
        groupingModel.name == newName &&
            groupingModel.initializeExpanded == newInitializeExpanded) {
      return groupingModel;
    }

    try {
      final GroupingModel newGroupingModel = groupingModel.copyWith(
        name: newName ?? groupingModel.name,
        initializeExpanded:
            newInitializeExpanded ?? groupingModel.initializeExpanded,
      );
      await _database
          .documentGroupsCollection(documentModel.id)
          .doc(newGroupingModel.id)
          .set(newGroupingModel.toMap());
      return newGroupingModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
