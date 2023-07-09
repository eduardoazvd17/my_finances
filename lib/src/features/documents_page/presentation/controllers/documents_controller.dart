import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_order_type.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';
import 'package:myfinances/src/features/documents_page/data/services/documents_service.dart';

import '../../../../core/data/enums/list_order.dart';
import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/utils/app_routes.dart';

class DocumentsController extends GetxController {
  final DocumentsService _financesService;
  DocumentsController({
    required DocumentsService financesService,
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

  final Rx<DocumentOrderType> _documentOrderType =
      Rx<DocumentOrderType>(DocumentOrderType.lastModifiedDate);

  DocumentOrderType get documentOrderType => _documentOrderType.value;
  set documentOrderType(DocumentOrderType value) {
    _documentOrderType.value = value;
    _sortDocuments();
  }

  final Rx<ListOrder> _sortOrder = Rx<ListOrder>(ListOrder.descending);
  ListOrder get sortOrder => _sortOrder.value;
  set sortOrder(ListOrder value) {
    _sortOrder.value = value;
    _sortDocuments();
  }

  void _sortDocuments() {
    _userDocuments.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) {
        return -1;
      } else if (b.isFavorite && !a.isFavorite) {
        return 1;
      } else {
        final isDescending = sortOrder == ListOrder.descending;
        return switch (documentOrderType) {
          DocumentOrderType.alphabetical =>
            isDescending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
          DocumentOrderType.lastModifiedDate => isDescending
              ? a.lastEditDate.compareTo(b.lastEditDate)
              : b.lastEditDate.compareTo(a.lastEditDate),
          DocumentOrderType.creationDate => isDescending
              ? a.creationDate.compareTo(b.creationDate)
              : b.creationDate.compareTo(a.creationDate),
        };
      }
    });
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

  void goToAddDocumentPage() {
    nameController.clear();
    _selectedDocumentType.value = DocumentType.values.first;
    AppRoutes.goToAddDocumentPage();
  }

  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode typeFocus = FocusNode();
  final Rx<DocumentType> _selectedDocumentType =
      Rx<DocumentType>(DocumentType.values.first);
  DocumentType get selectedDocumentType => _selectedDocumentType.value;
  set selectedDocumentType(DocumentType value) =>
      _selectedDocumentType.value = value;

  Future<void> createNewDocument() async {
    try {
      LoadingWidget.dialog();
      final String name = nameController.text.trim();
      final DocumentType type = selectedDocumentType;

      if (name.isEmpty) {
        throw AppError(message: 'document-name-validation'.i18n());
      }

      final DocumentModel documentModel = await _financesService.newDocument(
        name: name,
        documentType: type,
      );

      _userDocuments.add(documentModel);
      _sortDocuments();

      Get.close(2);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
    }
  }

  Future<void> deleteDocument(DocumentModel documentModel) async {
    try {
      LoadingWidget.dialog();
      await _financesService.deleteDocument(documentModel: documentModel);
      _userDocuments.remove(documentModel);
      Get.close(1);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
    }
  }

  Future<bool> editDocument({
    required DocumentModel documentModel,
    String? newName,
    bool? newIsFavorite,
  }) async {
    if ((newName == null && newIsFavorite == null) ||
        (newName == documentModel.name &&
            newIsFavorite == documentModel.isFavorite)) {
      return true;
    }

    try {
      //LoadingWidget.dialog();

      if (newName != null && newName.trim().isEmpty) {
        throw AppError(message: 'document-name-validation'.i18n());
      }

      final DocumentModel newDocumentModel =
          await _financesService.editDocument(
        documentModel: documentModel,
        newName: newName,
        newIsFavorite: newIsFavorite,
      );

      _userDocuments.remove(documentModel);
      _userDocuments.add(newDocumentModel);
      _sortDocuments();
      //Get.close(1);
      return true;
    } on AppError catch (appError) {
      //Get.close(1);
      appError.showDialog();
      return false;
    }
  }

  void openDocument(DocumentModel documentModel) {
    //TODO: Abrir documento.
  }
}
