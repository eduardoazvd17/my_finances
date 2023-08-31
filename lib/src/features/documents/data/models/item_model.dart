import 'package:equatable/equatable.dart';
import '../../../../core/data/utils/currency_utils.dart';
import '../enums/operation_type.dart';
import 'date_model.dart';

class ItemModel extends Equatable {
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
      'creationDate': creationDate.millisecondsSinceEpoch,
      'description': description,
      'groupingId': groupingId,
    };
  }

  @override
  List<Object?> get props => [id, name, creationDate, description, groupingId];
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
    String? name,
    required String? description,
    required String? groupingId,
    required int? quantity,
    required double? price,
  }) {
    return AnnotationItemModel(
      id: id,
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

  @override
  List<Object?> get props => [
        id,
        name,
        creationDate,
        description,
        groupingId,
        quantity,
        price,
        isChecked
      ];
}

class InvestimentControlItemModel extends ItemModel {
  final OperationType operationType;
  final int quantity;
  final double price;
  final DateTime date;

  @override
  String get name {
    return '${operationType.char} ${CurrencyUtils.format(quantity * price)} (${quantity}x${price.toStringAsFixed(2)})';
  }

  String get shortName {
    return '${CurrencyUtils.format(quantity * price)}\n${quantity}x ${price.toStringAsFixed(2)}';
  }

  const InvestimentControlItemModel({
    required super.id,
    required super.creationDate,
    super.name = '',
    required super.groupingId,
    super.description,
    required this.operationType,
    required this.quantity,
    required this.price,
    required this.date,
  });

  InvestimentControlItemModel editAndCopy({
    required String? description,
    OperationType? operationType,
    int? quantity,
    double? price,
    DateTime? date,
  }) {
    return InvestimentControlItemModel(
      id: id,
      name: name,
      description: description,
      creationDate: creationDate,
      groupingId: groupingId,
      operationType: operationType ?? this.operationType,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'operationType': operationType.index,
        'quantity': quantity,
        'price': price.toStringAsFixed(2),
        'date': date.millisecondsSinceEpoch,
      });
  }

  factory InvestimentControlItemModel.fromMap(Map<String, dynamic> map) {
    return InvestimentControlItemModel(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      description: map['description'],
      groupingId: map['groupingId'],
      operationType: OperationType.values[map['operationType']],
      quantity: map['quantity'],
      price: double.tryParse(map['price'] ?? '') ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        creationDate,
        description,
        groupingId,
        operationType,
        quantity,
        price,
        date,
      ];
}

class MonthlyExpenseControlItemModel extends ItemModel {
  final double price;
  final List<String> _recurringDates;
  final Map<String, double> _customDatesPrices;

  bool get isRecurring => _recurringDates.isNotEmpty;

  double priceByDateModel(DateModel dateModel) {
    return _customDatesPrices.containsKey(dateModel.code)
        ? (_customDatesPrices[dateModel.code] ?? price)
        : price;
  }

  const MonthlyExpenseControlItemModel({
    required super.id,
    required super.name,
    required super.creationDate,
    super.groupingId,
    super.description,
    required this.price,
    required List<String> recurringDates,
    required Map<String, double> customDatesPrices,
  })  : _recurringDates = recurringDates,
        _customDatesPrices = customDatesPrices;

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'price': price.toStringAsFixed(2),
        'recurringDates': _recurringDates,
        'customDatesPrices': _customDatesPrices,
      });
  }

  factory MonthlyExpenseControlItemModel.fromMap(Map<String, dynamic> map) {
    return MonthlyExpenseControlItemModel(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      description: map['description'],
      groupingId: map['groupingId'],
      price: double.parse(map['price']),
      recurringDates: List<String>.from(map['recurringDates']),
      customDatesPrices: Map<String, double>.from(map['customDatesPrices']),
    );
  }
}

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   const PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }

