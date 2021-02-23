import 'package:flutter/material.dart';

class Transaction {
  final String amount;
  final String language;
  final String currency;
  final String userId;

  Transaction(
      {@required this.amount,
      this.language = "en",
      this.currency = "AED",
      this.userId = "123456"});

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "language": language,
        "currency": currency,
        "user": userId
      };
}
