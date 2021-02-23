import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './model/billing_address.dart';
import './model/config.dart';
import './model/transaction.dart';

class TelrFlutter {
  final TelrConfiguration configuration;
  BillingAddress billingAddress;
  Transaction transaction;
  MethodChannel _channel = const MethodChannel('telr_flutter');

  TelrFlutter({@required this.configuration});

  Future<bool> _startTransaction() async {
    final bool status = await _channel.invokeMethod<bool>('startTransaction', {
      "config": configuration.toMap(),
      "billingAddress": billingAddress.toMap(),
      "transaction": transaction.toMap(),
    });
    log(status.toString());
    return status;
  }

  Future<bool> makePayment({@required Transaction transaction}) async {
    if (billingAddress == null) {
      return false;
    }
    this.transaction = transaction;
    return _startTransaction();
  }
}
