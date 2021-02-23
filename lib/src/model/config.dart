import 'package:flutter/material.dart';

class TelrConfiguration {
  final String key;
  final String storeId;
  final bool testMode;
  final bool enableSecurity;
  final String email;

  TelrConfiguration({
    @required this.key,
    @required this.storeId,
    this.testMode = false,
    this.enableSecurity = true,
    @required this.email,
  });

  Map<String, dynamic> toMap() => {
        "key": key,
        "storeId": storeId,
        "testMode": testMode,
        "enableSecurity": enableSecurity,
        "email": email,
      };
}
