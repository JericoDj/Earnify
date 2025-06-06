import 'package:flutter/material.dart';

class MonthlyGoalWidget extends StatelessWidget {
  final double totalEarnings;
  final double monthlyGoal;
  final double monthlyProgress;
  final TextEditingController goalController;
  final Future<void> Function(String) setMonthlyGoalCallback;
  const MonthlyGoalWidget({
    super.key,
    required this.totalEarnings,
    required this.monthlyGoal,
    required this.monthlyProgress,
    required this.goalController,
    required this.setMonthlyGoalCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: goalController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Set Monthly Goal',
            suffixIcon: Icon(Icons.flag),
          ),
          onSubmitted: (value) => setMonthlyGoalCallback(value),
        ),
        ElevatedButton(
          onPressed: () => setMonthlyGoalCallback(goalController.text),
          child: const Text('Set Monthly Goal'),
        ),
        Text('Monthly Goal: \$${monthlyGoal.toStringAsFixed(2)}'),
        LinearProgressIndicator(
          value: monthlyProgress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
        ),
        Text(
          'Monthly Progress: ${(monthlyProgress * 100).toStringAsFixed(1)}%',
        ),
      ],
    );
  }
}
