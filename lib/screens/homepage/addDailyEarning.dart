import 'package:flutter/material.dart';

class AddDailyEarnings extends StatelessWidget {
  final double dailyGoal;
  final double dailyProgress;
  final TextEditingController earningController;
  final Future<void> Function(String) addEarningCallback;
  final Future<void> Function(String) setDailyGoalCallback;
  final TextEditingController dailyGoalController;

  const AddDailyEarnings({
    super.key,
    required this.setDailyGoalCallback,
    required this.dailyGoal,
    required this.dailyProgress,
    required this.earningController,
    required this.addEarningCallback,
    required this.dailyGoalController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: dailyGoalController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Set Daily Goal',
            suffixIcon: Icon(Icons.today),
          ),
          onSubmitted: setDailyGoalCallback,
        ),
        ElevatedButton(
          onPressed: () => setDailyGoalCallback(dailyGoalController.text),
          child: const Text('Set Daily Goal'),
        ),
        Text('Daily Goal: \$${dailyGoal.toStringAsFixed(2)}'),
        LinearProgressIndicator(
          value: dailyProgress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
        Text('Daily Progress: ${(dailyProgress * 100).toStringAsFixed(1)}%'),
        const SizedBox(height: 24),
        TextField(
          controller: earningController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Add Daily Earning',
            suffixIcon: Icon(Icons.attach_money),
          ),
          onSubmitted: addEarningCallback,
        ),
        ElevatedButton(
          onPressed: () => addEarningCallback(earningController.text),
          child: const Text('Add Earning'),
        ),
      ],
    );
  }
}
