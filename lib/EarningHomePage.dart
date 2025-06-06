import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todokita/screens/controller/earningController.dart';
import 'package:todokita/screens/homepage/addDailyEarning.dart';
import 'package:todokita/screens/homepage/earningList.dart';
import 'package:todokita/screens/homepage/monthlyGoal.dart';

class EarningsHomePage extends ConsumerWidget {
  const EarningsHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earnings = ref.watch(earningsProvider);
    final controller = ref.read(earningsProvider.notifier);

    final TextEditingController earningController = TextEditingController();
    final TextEditingController dailyGoalController = TextEditingController();
    final TextEditingController monthlyGoalController = TextEditingController();

    final double monthlyProgress = earnings.monthlyGoal > 0
        ? (earnings.totalEarnings / earnings.monthlyGoal).clamp(0, 1)
        : 0;

    final double todayEarnings =
    earnings.dailyEarnings.isNotEmpty ? earnings.dailyEarnings.last : 0.0;

    final double dailyProgress = earnings.dailyGoal > 0
        ? (todayEarnings / earnings.dailyGoal).clamp(0, 1)
        : 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Kita')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonthlyGoalWidget(
              totalEarnings: earnings.totalEarnings,
              monthlyGoal: earnings.monthlyGoal,
              monthlyProgress: monthlyProgress,
              goalController: monthlyGoalController,
              setMonthlyGoalCallback: (value) => controller.setMonthlyGoal(value),
            ),
            const SizedBox(height: 24),
            AddDailyEarnings(
              setDailyGoalCallback: (value) => controller.setDailyGoal(value),
              dailyGoal: earnings.dailyGoal,
              dailyProgress: dailyProgress,
              earningController: earningController,
              addEarningCallback: (value) => controller.addEarning(value),
              dailyGoalController: dailyGoalController,
            ),
            const SizedBox(height: 24),
            EarningListWidget(dailyEarnings: earnings.dailyEarnings),
          ],
        ),
      ),
    );
  }
}