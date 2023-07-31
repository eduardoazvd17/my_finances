class ItemModel {
  final String id;
  final String name;
  final DateTime creationDate;
  final String? description;
  final String? groupingId;

  const ItemModel({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.description,
    required this.groupingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'creationDate': creationDate,
      'description': description,
      'groupingId': groupingId,
    };
  }

  //TODO: Implementar outros tipos de itens.
}

class AnnotationItemModel extends ItemModel {
  final int? quantity;
  final double? price;
  final bool isChecked;

  const AnnotationItemModel({
    required super.id,
    required super.name,
    required super.creationDate,
    super.description,
    super.groupingId,
    this.quantity,
    this.price,
    this.isChecked = false,
  });

  AnnotationItemModel toggleIsCheckedAndCopy() {
    return AnnotationItemModel(
      id: id,
      name: name,
      creationDate: creationDate,
      description: description,
      groupingId: groupingId,
      quantity: quantity,
      price: price,
      isChecked: !isChecked,
    );
  }

  AnnotationItemModel editAndCopy({
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
      creationDate: creationDate,
      description: description,
      groupingId: groupingId,
      quantity: quantity,
      price: price,
      isChecked: isChecked,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'quantity': quantity,
        'price': price?.toStringAsFixed(2),
        'isChecked': isChecked,
      });
  }

  factory AnnotationItemModel.fromMap(Map<String, dynamic> map) {
    return AnnotationItemModel(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      description: map['description'],
      groupingId: map['groupingId'],
      quantity: map['quantity'],
      price: double.tryParse(map['price'] ?? ''),
      isChecked: map['isChecked'] ?? false,
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
