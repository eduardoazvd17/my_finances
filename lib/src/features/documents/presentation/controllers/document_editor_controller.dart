import 'package:get/get.dart';
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
  void sortGroups() {
    _groups.sort((a, b) => a.title.compareTo(b.title));
  }

  final RxList<ItemModel> _items = RxList<ItemModel>([]);
  List<ItemModel> get itemsWithoutGroup =>
      _items.where((item) => item.groupingId == null).toList();
  List<ItemModel> getItemsByGroup(String groupingId) {
    return _items.where((item) => item.groupingId == groupingId).toList();
  }

  void sortItems() {
    _items.sort((a, b) => a.title.compareTo(b.title));
  }

  Future<void> _loadGroupsAndItems() async {
    _isLoading.value = true;
    try {
      final List<GroupingModel> tempGroups =
          await _documentEditorService.loadGroups(documentModel);
      final List<ItemModel> tempItems =
          await _documentEditorService.loadItems(documentModel);

      _groups.value = tempGroups;
      _items.value = tempItems;

      sortGroups();
      sortItems();
    } on AppError catch (appError) {
      appError.showDialog();
    }
    _isLoading.value = false;
  }
}
