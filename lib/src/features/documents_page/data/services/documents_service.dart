import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';
import '../enums/document_type.dart';

class FinancesService {
  final UserModel? userModel;
  final DatabaseModel _database;

  FinancesService({
    required this.userModel,
    required DatabaseModel database,
  }) : _database = database;

  Future<List<DocumentModel>> getUserDocuments() async {
    if (userModel == null) return [];

    try {
      final query = await _database.documentsCollection
          .where('ownerId', isEqualTo: userModel!.id)
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

  Future<void> newDocument({
    required String name,
    required DocumentType documentType,
  }) async {
    if (userModel == null) return;

    try {
      final DocumentReference docRef = _database.documentsCollection.doc();
      final DateTime dateTimeNow = DateTime.now();
      final DocumentModel documentModel = DocumentModel(
        id: docRef.id,
        name: name,
        ownerId: userModel!.id,
        creationDate: dateTimeNow,
        lastEditDate: dateTimeNow,
        type: documentType,
        isFavorite: false,
      );
      await docRef.set(documentModel.toMap());
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }

  Future<void> editDocument({required DocumentModel documentModel}) async {
    if (userModel == null) return;

    try {
      await _database.documentsCollection
          .doc(documentModel.id)
          .set(documentModel.toMap());
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
