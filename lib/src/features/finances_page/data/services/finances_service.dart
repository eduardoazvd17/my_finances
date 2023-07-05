import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/features/finances_page/data/models/document_model.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/database_model.dart';

class FinancesService {
  final UserModel? userModel;
  final DatabaseModel _database;

  FinancesService({
    required this.userModel,
    required DatabaseModel database,
  }) : _database = database;

  Future<List<DocumentModel>> getUserDocuments() async {
    try {
      if (userModel == null) return [];

      final query = await _database.documentsCollection
          .where('ownerId', isEqualTo: userModel!.id)
          .get();

      return query.docs.map((doc) => DocumentModel.fromMap(doc.data())).toList()
        ..sort((a, b) => b.lastEditDate.compareTo(a.lastEditDate));
    } on AppError catch (_) {
      rethrow;
    } catch (_) {
      throw AppError.generic();
    }
  }
}
