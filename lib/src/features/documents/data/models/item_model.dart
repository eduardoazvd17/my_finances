class ItemModel {
  final String title;
  final String? groupingId;
  ItemModel({required this.title, required this.groupingId});
}

class AnnotationItemModel extends ItemModel {
  final int? quantity;
  final double? price;

  AnnotationItemModel({
    required super.title,
    super.groupingId,
    this.quantity,
    this.price,
  });
}

//TODO: Implementar outros tipos de itens.

// class InvestimentControlItemModel extends ItemModel {
//   InvestimentControlItemModel({
//     required super.title,
//     super.groupingId,
//   });
// }

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   PointsAndAirlineMilesItemModel({
//     required super.title,
//     super.groupingId,
//   });
// }

// class MonthlyExpenseControlItemModel extends ItemModel {
//   MonthlyExpenseControlItemModel({
//     required super.title,
//     super.groupingId,
//   });
// }
