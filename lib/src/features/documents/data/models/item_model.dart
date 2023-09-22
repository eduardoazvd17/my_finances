import 'package:equatable/equatable.dart';
import '../../../../core/data/utils/currency_utils.dart';
import '../enums/operation_type.dart';
import '../enums/month_enum.dart';

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
  final double defaultPrice;
  final Set<MonthEnum> _recurringMonths;
  final Map<MonthEnum, double> _customPrices;

  bool get isRecurring => _recurringMonths.isNotEmpty;

  bool didShow(MonthEnum month) {
    return _recurringMonths.contains(month);
  }

  void addRecurringMonths(List<MonthEnum> months) {
    _recurringMonths.addAll(months);
  }

  double price(MonthEnum month) {
    return _customPrices.containsKey(month)
        ? (_customPrices[month] ?? defaultPrice)
        : defaultPrice;
  }

  void changeCustomPrice(MonthEnum month, double price) {
    _customPrices[month] = price;
  }

  MonthlyExpenseControlItemModel editAndCopy({
    String? name,
    double? defaultPrice,
  }) {
    return MonthlyExpenseControlItemModel(
      id: id,
      name: name ?? this.name,
      description: description,
      creationDate: creationDate,
      groupingId: groupingId,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      recurringMonths: _recurringMonths,
      customPrices: _customPrices,
    );
  }

  const MonthlyExpenseControlItemModel({
    required super.id,
    required super.name,
    required super.creationDate,
    super.groupingId,
    super.description,
    required this.defaultPrice,
    required Set<MonthEnum> recurringMonths,
    required Map<MonthEnum, double> customPrices,
  })  : _recurringMonths = recurringMonths,
        _customPrices = customPrices;

  @override
  Map<String, dynamic> toMap() {
    final Map<int, double> customPrices = {};
    for (final MonthEnum month in _customPrices.keys) {
      customPrices[month.index] = _customPrices[month] ?? defaultPrice;
    }

    return super.toMap()
      ..addAll({
        'defaultPrice': defaultPrice.toStringAsFixed(2),
        'recurringMonths': _recurringMonths.map((e) => e.index),
        'customPrices': customPrices,
      });
  }

  factory MonthlyExpenseControlItemModel.fromMap(Map<String, dynamic> map) {
    final Set<MonthEnum> recurringMonths = Set<int>.from(map['recurringMonths'])
        .map((e) => MonthEnum.values[e])
        .toSet();

    final rawCustomPrices = Map<int, double>.from(map['customPrices']);
    final Map<MonthEnum, double> customPrices = {};
    for (final int index in rawCustomPrices.keys) {
      final monthEnum = MonthEnum.values[index];
      customPrices[monthEnum] =
          rawCustomPrices[index] ?? double.parse(map['defaultPrice']);
    }

    return MonthlyExpenseControlItemModel(
      id: map['id'],
      name: map['name'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      description: map['description'],
      groupingId: map['groupingId'],
      defaultPrice: double.parse(map['defaultPrice']),
      recurringMonths: recurringMonths,
      customPrices: customPrices,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        creationDate,
        description,
        groupingId,
        defaultPrice,
        _recurringMonths,
        _customPrices,
      ];
}

// class PointsAndAirlineMilesItemModel extends ItemModel {
//   const PointsAndAirlineMilesItemModel({
//     required super.name,
//     super.groupingId,
//     super.description,
//   });
// }

