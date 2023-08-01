import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/documents/data/enums/operation_type.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';
import 'package:myfinances/src/features/documents/data/services/document_editor_service.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../data/models/document_model.dart';

class DocumentEditorController extends GetxController {
  final DocumentModel documentModel;
  final DocumentEditorService _documentEditorService;
  DocumentEditorController({
    required this.documentModel,
    required DocumentEditorService documentEditorService,
  }) : _documentEditorService = documentEditorService;

  @override
  void onInit() {
    _initializeData();
    super.onInit();
  }

  Future<void> _initializeData() async {
    _isLoading.value = true;
    try {
      final List<GroupingModel> tempGroups =
          await _documentEditorService.loadGroups();
      final List<ItemModel> tempItems =
          await _documentEditorService.loadItems();

      _groups.value = tempGroups;
      _items.value = tempItems;

      sortGroups();
      sortItems();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  final RxDouble _menuScrollPosition = RxDouble(0);
  double get menuScrollPosition => _menuScrollPosition.value;
  set menuScrollPosition(double value) => _menuScrollPosition.value = value;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxList<GroupingModel> _groups = RxList<GroupingModel>([]);
  List<GroupingModel> get groups => _groups.toList();
  void sortGroups() => _groups
      .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  final Rx<GroupingModel?> _selectedGroup = Rx<GroupingModel?>(null);
  GroupingModel? get selectedGroup => _selectedGroup.value;

  set selectedGroup(GroupingModel? value) {
    _selectedItem.value = null;
    _selectedGroup.value = value;
  }

  Future<bool> addOrEditGrouping({
    required GroupingModel? groupingModel,
    required String newName,
    required bool newInitializeExpanded,
  }) async {
    try {
      _isLoading.value = true;

      if (newName.isEmpty) {
        throw AppError(message: 'name-validation'.i18n());
      }

      final GroupingModel newGroupingModel;
      if (groupingModel == null) {
        newGroupingModel = await _documentEditorService.addGrouping(
          name: newName,
          initializeExpanded: newInitializeExpanded,
        );
      } else {
        newGroupingModel = await _documentEditorService.editGrouping(
          groupingModel: groupingModel,
          newName: newName,
          newInitializeExpanded: newInitializeExpanded,
        );
      }

      _groups.remove(groupingModel);
      _groups.add(newGroupingModel);
      if (groupingModel != null) {
        _selectedGroup.value = newGroupingModel;
      }
      sortGroups();
      _isLoading.value = false;
      return true;
    } on AppError catch (appError) {
      _isLoading.value = false;
      appError.showDialog();
      return false;
    }
  }

  Future<void> deleteGroup(GroupingModel groupingModel) async {
    _isLoading.value = true;
    try {
      await _documentEditorService.deleteGroup(groupingModel);
      _selectedGroup.value = null;
      if (_selectedItem.value?.groupingId == groupingModel.id) {
        _selectedItem.value = null;
      }
      _groups.remove(groupingModel);
      _items.removeWhere((item) => item.groupingId == groupingModel.id);
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  final RxList<ItemModel> _items = RxList<ItemModel>([]);
  List<ItemModel> get items => _items.toList();
  List<ItemModel> get itemsWithoutGroup =>
      _items.where((item) => item.groupingId == null).toList();
  List<ItemModel> getItemsByGroup(String groupingId) =>
      _items.where((item) => item.groupingId == groupingId).toList();
  void sortItems() => _items
      .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  final Rx<ItemModel?> _selectedItem = Rx<ItemModel?>(null);
  ItemModel? get selectedItem => _selectedItem.value;
  set selectedItem(ItemModel? value) {
    _selectedGroup.value = null;
    _selectedItem.value = value;
  }

  Future<bool> addOrEditAnnotationItem({
    required AnnotationItemModel? itemModel,
    required String newName,
    required String? newDescription,
    required String? newGroupingId,
    required int? newQuantity,
    required double? newPrice,
  }) async {
    try {
      _isLoading.value = true;

      if (newName.isEmpty) {
        throw AppError(message: 'name-validation'.i18n());
      }

      final AnnotationItemModel newItemModel;
      if (itemModel == null) {
        newItemModel = await _documentEditorService.addAnnotationItem(
          name: newName,
          description: newDescription == '' ? null : newDescription,
          groupingId: newGroupingId,
          quantity: newQuantity,
          price: newPrice,
        );
      } else {
        newItemModel = await _documentEditorService.editAnnotationItem(
          itemModel: itemModel,
          newName: newName,
          newDescription: newDescription == '' ? null : newDescription,
          newGroupingId: newGroupingId,
          newQuantity: newQuantity,
          newPrice: newPrice,
        );
      }

      _items.remove(itemModel);
      _items.add(newItemModel);
      if (selectedItem?.id == itemModel?.id && itemModel != null) {
        selectedItem = newItemModel;
      }
      sortItems();
      _isLoading.value = false;
      return true;
    } on AppError catch (appError) {
      _isLoading.value = false;
      appError.showDialog();
      return false;
    }
  }

  Future<void> toggleIsCheckedAnnotationItem(
    AnnotationItemModel itemModel,
  ) async {
    _isLoading.value = true;
    try {
      final ItemModel newItemModel =
          await _documentEditorService.toggleIsCheckedAnnotationItem(itemModel);
      _items.remove(itemModel);
      _items.add(newItemModel);
      selectedItem = newItemModel;
      sortItems();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  Future<void> uncheckAllAnnotationItems([String? groupingId]) async {
    _isLoading.value = true;
    try {
      final List<AnnotationItemModel> checkedItems;
      if (groupingId == null) {
        checkedItems = List<AnnotationItemModel>.from(
          _items.cast<AnnotationItemModel>().where((e) => e.isChecked),
        );
      } else {
        checkedItems = List<AnnotationItemModel>.from(
          getItemsByGroup(groupingId).cast<AnnotationItemModel>().where((e) {
            return e.isChecked;
          }),
        );
      }

      final Iterable<String> checkedItemsIds = checkedItems.map((e) => e.id);
      await _documentEditorService.uncheckAnnotationItems(checkedItemsIds);
      _items.removeWhere((e) => checkedItemsIds.contains(e.id));
      _items
          .addAll(checkedItems.map((e) => e.toggleIsCheckedAndCopy()).toList());
      sortItems();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }

  Future<bool> addOrEditInvestimentItem({
    InvestimentControlItemModel? itemModel,
    required String newGroupingId,
    required OperationType? newOperationType,
    required int? newQuantity,
    required double? newPrice,
    required String newDescription,
    required DateTime newDate,
  }) async {
    try {
      _isLoading.value = true;

      if (newOperationType == null) {
        throw AppError(message: 'operation-type-validation'.i18n());
      }

      if (newQuantity == null) {
        throw AppError(message: 'quantity-validation'.i18n());
      }

      if (newPrice == null) {
        throw AppError(message: 'price-validation'.i18n());
      }

      final InvestimentControlItemModel newItemModel;
      if (itemModel == null) {
        newItemModel = await _documentEditorService.addInvestimentItem(
          groupingId: newGroupingId,
          operationType: newOperationType,
          quantity: newQuantity,
          price: newPrice,
          description: newDescription,
          date: newDate,
        );
      } else {
        newItemModel = await _documentEditorService.editInvestimentItem(
          itemModel: itemModel,
          newOperationType: newOperationType,
          newQuantity: newQuantity,
          newPrice: newPrice,
          newDescription: newDescription,
          newDate: newDate,
        );
      }

      _items.remove(itemModel);
      _items.add(newItemModel);
      if (selectedItem?.id == itemModel?.id && itemModel != null) {
        selectedItem = newItemModel;
      }
      sortItems();
      _isLoading.value = false;
      return true;
    } on AppError catch (appError) {
      _isLoading.value = false;
      appError.showDialog();
      return false;
    }
  }

  Future<void> deleteItem(ItemModel itemModel) async {
    _isLoading.value = true;
    try {
      await _documentEditorService.deleteItem(itemModel);
      _items.remove(itemModel);
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }
}
