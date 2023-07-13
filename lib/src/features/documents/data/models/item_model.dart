class ItemModel {
  final String title;
  final String? groupingId;
  ItemModel({required this.title, required this.groupingId});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'groupingId': groupingId,
    };
  }
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

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'quantity': quantity,
        'price': price?.toStringAsFixed(2),
      });
  }

  factory AnnotationItemModel.fromMap(Map<String, dynamic> map) {
    return AnnotationItemModel(
      title: map['title'],
      groupingId: map['groupingId'],
      quantity: map['quantity'],
      price: double.tryParse(map['price']),
    );
  }
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
