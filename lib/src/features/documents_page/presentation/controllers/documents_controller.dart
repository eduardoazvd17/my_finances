import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';
import 'package:myfinances/src/features/documents_page/data/services/documents_service.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/utils/app_routes.dart';

class DocumentsController extends GetxController {
  final FinancesService _financesService;
  DocumentsController({
    required FinancesService financesService,
  }) : _financesService = financesService;

  @override
  void onInit() {
    _loadUserDocuments();
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxList<DocumentModel> _userDocuments = RxList<DocumentModel>();
  List<DocumentModel> get userDocuments => _userDocuments.toList();

  void _sortDocuments() {
    _userDocuments.sort((a, b) => b.lastEditDate.compareTo(a.lastEditDate));
  }

  Future<void> _loadUserDocuments() async {
    _isLoading.value = true;
    try {
      _userDocuments.value = await _financesService.getUserDocuments();
      _sortDocuments();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  void goToAddDocumentPage() => AppRoutes.goToAddDocumentPage();

  final TextEditingController nameController = TextEditingController();
  final Rx<DocumentType> _selectedDocumentType =
      Rx<DocumentType>(DocumentType.values.first);
  DocumentType get selectedDocumentType => _selectedDocumentType.value;
  set selectedDocumentType(DocumentType value) =>
      _selectedDocumentType.value = value;
}
