import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
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
    _loadGroupsAndItems();
    super.onInit();
  }

  final RxDouble _menuScrollPosition = RxDouble(0);
  double get menuScrollPosition => _menuScrollPosition.value;
  set menuScrollPosition(double value) => _menuScrollPosition.value = value;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxList<GroupingModel> _groups = RxList<GroupingModel>([]);
  List<GroupingModel> get groups => _groups.toList();
  void sortGroups() => _groups.sort((a, b) => a.name.compareTo(b.name));

  final RxList<ItemModel> _items = RxList<ItemModel>([]);
  List<ItemModel> get itemsWithoutGroup =>
      _items.where((item) => item.groupingId == null).toList();
  List<ItemModel> getItemsByGroup(String groupingId) =>
      _items.where((item) => item.groupingId == groupingId).toList();
  void sortItems() => _items.sort((a, b) => a.name.compareTo(b.name));

  Future<void> _loadGroupsAndItems() async {
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

  Future<bool> addOrEditGrouping({
    required GroupingModel? groupingModel,
    required String newName,
    required bool newInitializeExpanded,
  }) async {
    try {
      LoadingWidget.dialog();

      if (newName.isEmpty) {
        throw AppError(message: 'group-name-validation'.i18n());
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
      sortGroups();
      Get.close(1);
      return true;
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
      return false;
    }
  }

  final Rx<GroupingModel?> _selectedGroup = Rx<GroupingModel?>(null);
  GroupingModel? get selectedGroup => _selectedGroup.value;
  set selectedGroup(GroupingModel? value) => _selectedGroup.value = value;
}
