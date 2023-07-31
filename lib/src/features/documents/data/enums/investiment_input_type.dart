import 'package:flutter/material.dart';

enum InputType {
  buy,
  sell,
}

extension InputTypeExtension on InputType {
  Icon get icon {
    return switch (this) {
      InputType.buy => const Icon(Icons.attach_money, color: Colors.green),
      InputType.sell => Icon(Icons.money_off, color: Colors.red[200]),
    };
  }
}
