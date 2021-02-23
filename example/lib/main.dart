import 'package:flutter/material.dart';
import 'package:telr_flutter/telrFlutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startPaymentProcess() {
    var telr = TelrFlutter(
      configuration: TelrConfiguration(
        key: "pQ6nP-7rHt@5WRFv",
        storeId: "15996",
        email: "girish.spryox@gmail.com",
        enableSecurity: false,
        testMode: true,
      ),
    );
    telr.billingAddress = BillingAddress(
        city: "Dubai",
        country: "AE",
        firstName: "Basem",
        lastName: "Abduallah",
        line: "236b stree",
        phoneNumber: "01007898142",
        region: "Dubai");
    telr.makePayment(
      transaction: Transaction(amount: "2"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: startPaymentProcess,
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
