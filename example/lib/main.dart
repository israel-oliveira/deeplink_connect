import 'package:flutter/material.dart';
import 'package:deeplink_connect/deeplink_connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deepLinkResponse = 'No response';
  final DeeplinkConnect _deeplinkConnect = DeeplinkConnect();

  @override
  void initState() {
    super.initState();
    _initDeepLinkResponseListener();
  }

  @override
  void dispose() {
    _deeplinkConnect.close();
    super.dispose();
  }

  // Initialize listener for deep link responses
  void _initDeepLinkResponseListener() {
    _deeplinkConnect.onDeepLinkResponse?.listen((response) {
      setState(() {
        _deepLinkResponse = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Text('Deep Link Response: $_deepLinkResponse'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Example URI string
            String uriString = DeeplinkPayment.build(
              authority: "pay",
              scheme: "payment-app",
              returnScheme: "return-pdv",
              amount: 1000,
              transactionType: TransactionType.credit,
            ).getUri();

            // Call the pay method
            await _deeplinkConnect.send(uriString);
          },
          tooltip: 'Pay',
          child: const Icon(Icons.payment),
        ),
      ),
    );
  }
}
