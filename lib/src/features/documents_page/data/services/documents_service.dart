import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';

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
      final DateTime dateTimeNow = DateTime.now();
      final DocumentModel documentModel = DocumentModel(
        id: docRef.id,
        name: name,
        ownerId: userModel.id,
        creationDate: dateTimeNow,
        lastEditDate: dateTimeNow,
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
    try {
      final DocumentModel? newDocumentModel;
      if (newName != null &&
          newIsFavorite != null &&
          newName != documentModel.name &&
          newIsFavorite != documentModel.isFavorite) {
        newDocumentModel = documentModel.copyWith(
          name: newName,
          isFavorite: newIsFavorite,
          lastEditDate: DateTime.now(),
        );
      } else if (newName != null && newName != documentModel.name) {
        newDocumentModel = documentModel.copyWith(
          name: newName,
          lastEditDate: DateTime.now(),
        );
      } else if (newIsFavorite != null &&
          newIsFavorite != documentModel.isFavorite) {
        newDocumentModel = documentModel.copyWith(
          isFavorite: newIsFavorite,
        );
      } else {
        newDocumentModel = null;
      }

      if (newDocumentModel != null) {
        await _database.documentsCollection
            .doc(newDocumentModel.id)
            .set(newDocumentModel.toMap());
      }
      return newDocumentModel ?? documentModel;
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> deleteDocument({required DocumentModel documentModel}) async {
    try {
      await _database.documentsCollection.doc(documentModel.id).delete();
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
