import 'package:flutter/material.dart';

class BillingAddress {
  final String city;
  final String country;
  final String region;
  final String line;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  BillingAddress({
    @required this.city,
    @required this.country,
    @required this.region,
    @required this.line,
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
  });

  Map<String, dynamic> toMap() => {
        "city": city,
        "country": country,
        "region": region,
        "line": line,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      };
}
