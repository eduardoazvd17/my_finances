import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/features/documents/data/enums/document_order_type.dart';
import 'package:myfinances/src/features/documents/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents/data/models/document_model.dart';
import 'package:myfinances/src/features/documents/data/services/documents_service.dart';

import '../../../../core/data/enums/list_order.dart';
import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/utils/app_routes.dart';

class DocumentsController extends GetxController {
  final DocumentsService _documentsService;

  DocumentsController({
    required DocumentsService documentsService,
  }) : _documentsService = documentsService;

  @override
  void onInit() {
    _loadUserDocuments();
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxDouble _documentsScrollPosition = RxDouble(0.0);
  double get documentsScrollPosition => _documentsScrollPosition.value;
  set documentsScrollPosition(double value) =>
      _documentsScrollPosition.value = value;

  final RxList<DocumentModel> _userDocuments = RxList<DocumentModel>();
  List<DocumentModel> get userDocuments => _userDocuments.toList();
  Future<void> _loadUserDocuments() async {
    _isLoading.value = true;
    try {
      await _loadSortSettings();
      _userDocuments.value = await _documentsService.getUserDocuments();
      _sortDocuments();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  final Rx<DocumentOrderType> _documentOrderType = Rx<DocumentOrderType>(
    DocumentOrderType.creationDate,
  );
  DocumentOrderType get documentOrderType => _documentOrderType.value;
  Future<void> setDocumentOrderType(
    DocumentOrderType value, {
    bool withoutSaving = false,
  }) async {
    _documentOrderType.value = value;
    _sortDocuments();
    if (!withoutSaving) await _saveSortSettings();
  }

  final Rx<ListOrder> _sortOrder = Rx<ListOrder>(ListOrder.descending);
  ListOrder get sortOrder => _sortOrder.value;
  Future<void> setSortOrder(
    ListOrder value, {
    bool withoutSaving = false,
  }) async {
    _sortOrder.value = value;
    _sortDocuments();
    if (!withoutSaving) await _saveSortSettings();
  }

  Future<void> _saveSortSettings() async {
    _documentsService.saveDocumentOrderType(
      type: documentOrderType,
      order: sortOrder,
    );
  }

  Future<void> _loadSortSettings() async {
    final (DocumentOrderType, ListOrder) values =
        await _documentsService.getSavedDocumentOrderType();
    setDocumentOrderType(values.$1, withoutSaving: true);
    setSortOrder(values.$2, withoutSaving: true);
  }

  void _sortDocuments() {
    _userDocuments.sort((a, b) {
      if (a.isFavorite != b.isFavorite) {
        return a.isFavorite ? -1 : 1;
      } else {
        return switch (sortOrder) {
          ListOrder.ascending => switch (documentOrderType) {
              DocumentOrderType.alphabetical =>
                a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              DocumentOrderType.creationDate =>
                a.creationDate.compareTo(b.creationDate),
            },
          ListOrder.descending => switch (documentOrderType) {
              DocumentOrderType.alphabetical =>
                b.name.toLowerCase().compareTo(a.name.toLowerCase()),
              DocumentOrderType.creationDate =>
                b.creationDate.compareTo(a.creationDate),
            },
        };
      }
    });
  }

  void goToAddDocumentPage() {
    nameController.clear();
    _selectedDocumentType.value = null;
    AppRoutes.goToAddDocumentPage();
  }

  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode typeFocus = FocusNode();
  final Rx<DocumentType?> _selectedDocumentType = Rx<DocumentType?>(null);
  DocumentType? get selectedDocumentType => _selectedDocumentType.value;
  set selectedDocumentType(DocumentType? value) =>
      _selectedDocumentType.value = value;

  Future<void> createNewDocument() async {
    FocusNode? focusNode;
    try {
      LoadingWidget.dialog();
      final String name = nameController.text.trim();
      final DocumentType? type = selectedDocumentType;

      if (name.isEmpty) {
        focusNode = nameFocus;
        throw AppError(message: 'name-validation'.i18n());
      }

      if (type == null) {
        focusNode = typeFocus;
        throw AppError(message: 'document-type-validation'.i18n());
      }

      final DocumentModel documentModel = await _documentsService.newDocument(
        name: name,
        documentType: type,
      );

      _userDocuments.add(documentModel);
      _sortDocuments();

      Get.close(2);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog().then((_) => focusNode?.requestFocus());
    }
  }

  Future<void> deleteDocument(DocumentModel documentModel) async {
    try {
      LoadingWidget.dialog();
      await _documentsService.deleteDocument(documentModel: documentModel);
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
        throw AppError(message: 'name-validation'.i18n());
      }

      final DocumentModel newDocumentModel =
          await _documentsService.editDocument(
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
    AppRoutes.goToDocumentEditorPage(
      documentModel: documentModel,
    );
  }
}
