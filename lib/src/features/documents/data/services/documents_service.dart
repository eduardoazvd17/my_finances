import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/enums/list_order.dart';
import '../../../../core/data/models/user_model.dart';
import '../enums/document_order_type.dart';
import '../models/document_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../enums/document_type.dart';

class DocumentsService {
  final UserModel userModel;
  final DatabaseModel _database;

  DocumentsService({
    required this.userModel,
    required DatabaseModel database,
  }) : _database = database;

  Future<List<DocumentModel>> getUserDocuments() async {
    try {
      final query = await _database.documentsCollection
          .where('ownerId', isEqualTo: userModel.id)
          .get();

      return query.docs
          .map((doc) => DocumentModel.fromMap(doc.data()))
          .toList();
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<DocumentModel> newDocument({
    required String name,
    required DocumentType documentType,
  }) async {
    try {
      final DocumentReference docRef = _database.documentsCollection.doc();
      final DocumentModel documentModel = DocumentModel(
        id: docRef.id,
        name: name,
        ownerId: userModel.id,
        creationDate: DateTime.now(),
        type: documentType,
        isFavorite: false,
      );
      await docRef.set(documentModel.toMap());
      return documentModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<DocumentModel> editDocument({
    required DocumentModel documentModel,
    String? newName,
    bool? newIsFavorite,
  }) async {
    if (newName != null && newIsFavorite != null ||
        newName == documentModel.name &&
            newIsFavorite == documentModel.isFavorite) {
      return documentModel;
    }

    try {
      final DocumentModel newDocumentModel = documentModel.editAndCopy(
        name: newName ?? documentModel.name,
        isFavorite: newIsFavorite ?? documentModel.isFavorite,
      );
      await _database.documentsCollection
          .doc(newDocumentModel.id)
          .set(newDocumentModel.toMap());
      return newDocumentModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> deleteDocument({required DocumentModel documentModel}) async {
    try {
      await _database.documentsCollection.doc(documentModel.id).delete();

      final documentsGroupsQuery =
          await _database.documentGroupsCollection(documentModel.id).get();
      if (documentsGroupsQuery.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();
        for (final doc in documentsGroupsQuery.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }

      final documentsItemsQuery =
          await _database.documentItemsCollection(documentModel.id).get();
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

  Future<void> saveDocumentOrderType({
    required DocumentOrderType type,
    required ListOrder order,
  }) async {
    try {
      final prefs = await _database.sharedPreferences;
      prefs.setInt('DocumentOrderType', type.index);
      prefs.setInt('DocumentListOrder', type.index);
    } catch (_) {}
  }

  Future<(DocumentOrderType, ListOrder)> getSavedDocumentOrderType() async {
    try {
      final prefs = await _database.sharedPreferences;
      final int documentOrderTypeIndex = prefs.getInt('DocumentOrderType') ??
          DocumentOrderType.creationDate.index;
      final int listOrderIndex =
          prefs.getInt('DocumentListOrder') ?? ListOrder.descending.index;

      return (
        DocumentOrderType.values[documentOrderTypeIndex],
        ListOrder.values[listOrderIndex],
      );
    } catch (_) {
      return (DocumentOrderType.creationDate, ListOrder.descending);
    }
  }
}
