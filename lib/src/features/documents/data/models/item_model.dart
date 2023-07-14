class ItemModel {
  final String name;
  final String? groupingId;
  ItemModel({required this.name, required this.groupingId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'groupingId': groupingId,
    };
  }

  //TODO: Implementar outros tipos de itens.
}

class AnnotationItemModel extends ItemModel {
  final int? quantity;
  final double? price;

  AnnotationItemModel({
    required super.name,
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
      name: map['name'],
      groupingId: map['groupingId'],
      quantity: map['quantity'],
      price: double.tryParse(map['price']),
    );
  }
}

// class InvestimentControlItemModel extends ItemModel {
//   InvestimentControlItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }

// class MonthlyExpenseControlItemModel extends ItemModel {
//   MonthlyExpenseControlItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }
