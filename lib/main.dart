import 'package:earnify/EarningHomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EarningsTrackerApp());
}

class EarningsTrackerApp extends StatelessWidget {
  const EarningsTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earnings Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const EarningsHomePage(),
    );
  }
}
