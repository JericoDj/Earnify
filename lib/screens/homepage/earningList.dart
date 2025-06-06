import 'package:flutter/material.dart';
class EarningListWidget extends StatelessWidget {
  final List<double> dailyEarnings;

  const EarningListWidget({super.key,
    required this.dailyEarnings});

  @override
  Widget build(BuildContext context) {
    if (dailyEarnings.isEmpty) {
      return const Text('No earnings yet.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // disable inner scroll
      itemCount: dailyEarnings.length,
      itemBuilder: (context, index) {
        final earning = dailyEarnings[index];
        return ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text('Earning \$${earning.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
