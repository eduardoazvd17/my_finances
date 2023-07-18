class ItemModel {
  final String id;
  final String name;
  final String? description;
  final String? groupingId;

  const ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.groupingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupingId': groupingId,
    };
  }

  //TODO: Implementar outros tipos de itens.
}

class AnnotationItemModel extends ItemModel {
  final int? quantity;
  final double? price;

  const AnnotationItemModel({
    required super.id,
    required super.name,
    super.description,
    super.groupingId,
    this.quantity,
    this.price,
  });

  AnnotationItemModel copyWith({
    String? id,
    String? name,
    String? description,
    String? groupingId,
    int? quantity,
    double? price,
  }) {
    return AnnotationItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description,
      groupingId: groupingId,
      quantity: quantity,
      price: price,
    );
  }

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
      id: map['id'],
      name: map['name'],
      description: map['description'],
      groupingId: map['groupingId'],
      quantity: map['quantity'],
      price: double.tryParse(map['price'] ?? ''),
    );
  }
}

// class InvestimentControlItemModel extends ItemModel {
//   const InvestimentControlItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   const PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }

// class MonthlyExpenseControlItemModel extends ItemModel {
//   const MonthlyExpenseControlItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }
