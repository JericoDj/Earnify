
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show AppBar, Colors, ElevatedButton, Icons, InputDecoration, LinearProgressIndicator, ListTile, Scaffold, TextField;

class EarningsHomePage extends StatefulWidget {
  const EarningsHomePage({super.key});

  @override
  State<EarningsHomePage> createState() => _EarningsHomePageState();
}

class _EarningsHomePageState extends State<EarningsHomePage> {
  double _monthlyGoal = 0.0;
  double _dailyGoal = 0.0;
  double _totalEarnings = 0.0;
  final List<double> _dailyEarnings = [];
  final TextEditingController _earningController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _dailyGoalController = TextEditingController();

  void _addEarning() {
    final earning = double.tryParse(_earningController.text);
    if (earning != null && earning > 0) {
      setState(() {
        _dailyEarnings.add(earning);
        _totalEarnings += earning;
        _earningController.clear();
      });
    }
  }

  void _setMonthlyGoal() {
    final goal = double.tryParse(_goalController.text);
    if (goal != null && goal > 0) {
      setState(() {
        _monthlyGoal = goal;
        _goalController.clear();
      });
    }
  }

  void _setDailyGoal() {
    final goal = double.tryParse(_dailyGoalController.text);
    if (goal != null && goal > 0) {
      setState(() {
        _dailyGoal = goal;
        _dailyGoalController.clear();
      });
    }
  }

  double get _todayEarnings =>
      _dailyEarnings.isNotEmpty ? _dailyEarnings.last : 0.0;

  @override
  Widget build(BuildContext context) {
    double monthlyProgress =
    _monthlyGoal > 0 ? (_totalEarnings / _monthlyGoal).clamp(0, 1) : 0;
    double dailyProgress =
    _dailyGoal > 0 ? (_todayEarnings / _dailyGoal).clamp(0, 1) : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Monthly Goal
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Set Monthly Goal',
                suffixIcon: Icon(Icons.flag),
              ),
              onSubmitted: (_) => _setMonthlyGoal(),
            ),
            ElevatedButton(
              onPressed: _setMonthlyGoal,
              child: const Text('Set Monthly Goal'),
            ),
            Text('Monthly Goal: \$${_monthlyGoal.toStringAsFixed(2)}'),
            LinearProgressIndicator(
              value: monthlyProgress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            Text('Monthly Progress: ${(monthlyProgress * 100).toStringAsFixed(1)}%'),
            const SizedBox(height: 16),

            // Daily Goal
            TextField(
              controller: _dailyGoalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Set Daily Goal',
                suffixIcon: Icon(Icons.today),
              ),
              onSubmitted: (_) => _setDailyGoal(),
            ),
            ElevatedButton(
              onPressed: _setDailyGoal,
              child: const Text('Set Daily Goal'),
            ),
            Text('Daily Goal: \$${_dailyGoal.toStringAsFixed(2)}'),
            LinearProgressIndicator(
              value: dailyProgress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            Text('Daily Progress: ${(dailyProgress * 100).toStringAsFixed(1)}%'),
            const SizedBox(height: 16),

            // Add Earning
            TextField(
              controller: _earningController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Add Daily Earning',
                suffixIcon: Icon(Icons.attach_money),
              ),
              onSubmitted: (_) => _addEarning(),
            ),
            ElevatedButton(
              onPressed: _addEarning,
              child: const Text('Add Earning'),
            ),
            const SizedBox(height: 16),

            // Earnings List
            Expanded(
              child: ListView.builder(
                itemCount: _dailyEarnings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.monetization_on),
                    title: Text('Day ${index + 1}: \$${_dailyEarnings[index].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}