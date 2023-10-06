import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/value_type.dart';
import '../models/grouping_model.dart';
import '../models/item_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../enums/document_type.dart';
import '../enums/operation_type.dart';
import '../models/document_model.dart';
import '../models/values_by_month_dto.dart';

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
      return switch (documentModel.type) {
        DocumentType.monthlyExpenseControl => query.docs
            .map((doc) => MonthlyExpenseControlItemModel.fromMap(doc.data()))
            .toList(),
        DocumentType.investmentControl => query.docs
            .map((doc) => InvestimentControlItemModel.fromMap(doc.data()))
            .toList(),
        DocumentType.annotation => query.docs
            .map((doc) => AnnotationItemModel.fromMap(doc.data()))
            .toList(),
        //DocumentType.pointsAndAirlineMiles => [],
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
      final GroupingModel newGroupingModel = groupingModel.editAndCopy(
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

  Future<void> deleteGroup(GroupingModel groupingModel) async {
    try {
      await _database
          .documentGroupsCollection(documentModel.id)
          .doc(groupingModel.id)
          .delete();

      final documentsItemsQuery = await _database
          .documentItemsCollection(documentModel.id)
          .where('groupingId', isEqualTo: groupingModel.id)
          .get();
      if (documentsItemsQuery.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();
        for (final doc in documentsItemsQuery.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<AnnotationItemModel> addAnnotationItem({
    required String name,
    required String? description,
    required String? groupingId,
    required int? quantity,
    required double? price,
  }) async {
    try {
      final docRef = _database.documentItemsCollection(documentModel.id).doc();
      final AnnotationItemModel itemModel = AnnotationItemModel(
        id: docRef.id,
        name: name,
        creationDate: DateTime.now(),
        description: description,
        groupingId: groupingId,
        quantity: quantity,
        price: price,
      );
      await docRef.set(itemModel.toMap());
      return itemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<AnnotationItemModel> editAnnotationItem({
    required AnnotationItemModel itemModel,
    required String? newName,
    required String? newDescription,
    required String? newGroupingId,
    required int? newQuantity,
    required double? newPrice,
  }) async {
    if (itemModel.name == newName &&
        itemModel.description == newDescription &&
        itemModel.groupingId == newGroupingId &&
        itemModel.quantity == newQuantity &&
        itemModel.price == newPrice) {
      return itemModel;
    }

    try {
      final AnnotationItemModel newItemModel = itemModel.editAndCopy(
        name: newName ?? itemModel.name,
        description: newDescription,
        groupingId: newGroupingId,
        quantity: newQuantity,
        price: newPrice,
      );

      await _database
          .documentItemsCollection(documentModel.id)
          .doc(newItemModel.id)
          .set(newItemModel.toMap());

      return newItemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> deleteItem(ItemModel itemModel) async {
    try {
      await _database
          .documentItemsCollection(documentModel.id)
          .doc(itemModel.id)
          .delete();
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<ItemModel> toggleIsCheckedAnnotationItem(
    AnnotationItemModel itemModel,
  ) async {
    try {
      await _database
          .documentItemsCollection(documentModel.id)
          .doc(itemModel.id)
          .update({'isChecked': !itemModel.isChecked});
      return itemModel.toggleIsCheckedAndCopy();
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> uncheckAnnotationItems(Iterable<String> checkedIds) async {
    try {
      for (final String id in checkedIds) {
        await _database
            .documentItemsCollection(documentModel.id)
            .doc(id)
            .update({'isChecked': false});
      }
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<InvestimentControlItemModel> addInvestimentItem({
    required String groupingId,
    required OperationType operationType,
    required int quantity,
    required double price,
    required String? description,
    required DateTime date,
  }) async {
    try {
      final docRef = _database.documentItemsCollection(documentModel.id).doc();
      final InvestimentControlItemModel itemModel = InvestimentControlItemModel(
        id: docRef.id,
        creationDate: DateTime.now(),
        groupingId: groupingId,
        operationType: operationType,
        quantity: quantity,
        price: price,
        date: date,
      );
      await docRef.set(itemModel.toMap());
      return itemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<InvestimentControlItemModel> editInvestimentItem({
    required InvestimentControlItemModel itemModel,
    required OperationType newOperationType,
    required int newQuantity,
    required double newPrice,
    required String? newDescription,
    required DateTime newDate,
  }) async {
    if (itemModel.operationType == newOperationType &&
        itemModel.quantity == newQuantity &&
        itemModel.price == newPrice &&
        itemModel.description == newDescription &&
        itemModel.date == newDate) {
      return itemModel;
    }

    try {
      final InvestimentControlItemModel newItemModel = itemModel.editAndCopy(
        description: newDescription,
        operationType: newOperationType,
        quantity: newQuantity,
        price: newPrice,
        date: newDate,
      );

      await _database
          .documentItemsCollection(documentModel.id)
          .doc(newItemModel.id)
          .set(newItemModel.toMap());

      return newItemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<MonthlyExpenseControlItemModel> addMonthlyControlItem({
    required String name,
    required String groupingId,
    required ValueType valueType,
    required double defaultValue,
    required ValuesByMonthDTO valuesByMonth,
  }) async {
    try {
      final docRef = _database.documentItemsCollection(documentModel.id).doc();
      final MonthlyExpenseControlItemModel itemModel =
          MonthlyExpenseControlItemModel(
        id: docRef.id,
        name: name,
        creationDate: DateTime.now(),
        groupingId: groupingId,
        valueType: valueType,
        defaultValue: defaultValue,
        valuesByMonth: valuesByMonth,
      );
      await docRef.set(itemModel.toMap());
      return itemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<MonthlyExpenseControlItemModel> editMonthlyControlItem({
    required MonthlyExpenseControlItemModel itemModel,
    required String newName,
    required String newGroupingId,
    required ValueType newValueType,
    required double newDefaultValue,
    required ValuesByMonthDTO newValuesByMonth,
  }) async {
    if (itemModel.name == newName &&
        itemModel.groupingId == newGroupingId &&
        itemModel.valueType == newValueType &&
        itemModel.defaultValue == newDefaultValue &&
        itemModel.valuesByMonth == newValuesByMonth) {
      return itemModel;
    }

    try {
      final MonthlyExpenseControlItemModel newItemModel = itemModel.editAndCopy(
        name: newName,
        groupingId: newGroupingId,
        valueType: newValueType,
        defaultValue: newDefaultValue,
        valuesByMonth: newValuesByMonth,
      );

      await _database
          .documentItemsCollection(documentModel.id)
          .doc(newItemModel.id)
          .set(newItemModel.toMap());

      return newItemModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
