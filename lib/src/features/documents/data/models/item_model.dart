import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final String id;
  final String name;
  final String? groupingId;

  const ItemModel({
    required this.id,
    required this.name,
    required this.groupingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupingId': groupingId,
    };
  }

  @override
  List<Object?> get props => [id];

  //TODO: Implementar outros tipos de itens.
}

class AnnotationItemModel extends ItemModel {
  final int? quantity;
  final double? price;

  const AnnotationItemModel({
    required super.id,
    required super.name,
    super.groupingId,
    this.quantity,
    this.price,
  });

  AnnotationItemModel copyWith({
    String? id,
    String? name,
    String? groupingId,
    int? quantity,
    double? price,
  }) {
    return AnnotationItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      groupingId: groupingId ?? this.groupingId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
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
      groupingId: map['groupingId'],
      quantity: map['quantity'],
      price: double.tryParse(map['price']),
    );
  }
}

// class InvestimentControlItemModel extends ItemModel {
//   const InvestimentControlItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   const PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }

// class MonthlyExpenseControlItemModel extends ItemModel {
//   const MonthlyExpenseControlItemModel({
//     required super.name,
//     super.groupingId,
//   });
// }
