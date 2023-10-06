import 'package:equatable/equatable.dart';
import '../../../../core/data/utils/currency_utils.dart';
import '../enums/operation_type.dart';
import '../enums/month_enum.dart';
import '../enums/value_type.dart';
import 'months_values_dto.dart';

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

  String get desktopName {
    return '${CurrencyUtils.format(quantity * price)}  (${quantity}x ${CurrencyUtils.format(price)})';
  }

  String get mobileName {
    return '${CurrencyUtils.format(quantity * price)}\n${quantity}x ${CurrencyUtils.format(price)}';
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
  final ValueType valueType;
  final MonthEnum? singleMonth;
  final double defaultValue;
  final MonthValuesDTO valuesByMonth;

  bool get isRecurring => singleMonth == null;
  Set<MonthEnum> get recurringMonths => valuesByMonth.values.keys.toSet();

  double value(MonthEnum month) => valuesByMonth.get(month) ?? defaultValue;
  bool existsIn(MonthEnum month) =>
      singleMonth == month || valuesByMonth.get(month) != null;

  MonthlyExpenseControlItemModel editAndCopy({
    String? name,
    String? groupingId,
    ValueType? valueType,
    required MonthEnum? singleMonth,
    double? defaultValue,
    MonthValuesDTO? valuesByMonth,
  }) {
    return MonthlyExpenseControlItemModel(
      id: id,
      description: description,
      creationDate: creationDate,
      name: name ?? this.name,
      groupingId: groupingId ?? this.groupingId,
      valueType: valueType ?? this.valueType,
      singleMonth: singleMonth,
      defaultValue: defaultValue ?? this.defaultValue,
      valuesByMonth: valuesByMonth ?? this.valuesByMonth,
    );
  }

  const MonthlyExpenseControlItemModel({
    required super.id,
    required super.name,
    required super.creationDate,
    super.groupingId,
    super.description,
    required this.valueType,
    required this.singleMonth,
    required this.defaultValue,
    required this.valuesByMonth,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'valueType': valueType.index,
        'singleMonth': singleMonth?.index,
        'defaultValue': defaultValue.toStringAsFixed(2),
        'valuesByMonth': valuesByMonth.toMap(),
      });
  }

  factory MonthlyExpenseControlItemModel.fromMap(Map<String, dynamic> map) {
    return MonthlyExpenseControlItemModel(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      description: map['description'],
      groupingId: map['groupingId'],
      valueType: ValueType.values[map['valueType']],
      singleMonth: map['singleMonth'] != null
          ? MonthEnum.values[map['singleMonth']]
          : null,
      defaultValue: double.tryParse(map['defaultValue'] ?? '') ?? 0.0,
      valuesByMonth: MonthValuesDTO.fromMap(
        Map<String, String>.from(map['valuesByMonth']),
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        creationDate,
        description,
        groupingId,
        valueType,
        valuesByMonth,
      ];
}

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   const PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }

