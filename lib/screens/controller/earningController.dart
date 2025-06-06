import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarningsState {
  final double totalEarnings;
  final double dailyGoal;
  final double monthlyGoal;
  final List<double> dailyEarnings;

  EarningsState({
    this.totalEarnings = 0.0,
    this.dailyGoal = 0.0,
    this.monthlyGoal = 0.0,
    this.dailyEarnings = const [],
  });

  EarningsState copyWith({
    double? totalEarnings,
    double? dailyGoal,
    double? monthlyGoal,
    List<double>? dailyEarnings,
  }) {
    return EarningsState(
      totalEarnings: totalEarnings ?? this.totalEarnings,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      monthlyGoal: monthlyGoal ?? this.monthlyGoal,
      dailyEarnings: dailyEarnings ?? this.dailyEarnings,
    );
  }
}

class EarningsController extends StateNotifier<EarningsState> {
  EarningsController() : super(EarningsState());

  Future<void> setDailyGoal(String value) async {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed > 0) {
      state = state.copyWith(dailyGoal: parsed);
    }
  }

  Future<void> setMonthlyGoal(String value) async {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed > 0) {
      state = state.copyWith(monthlyGoal: parsed);
    }
  }

  Future<void> addEarning(String value) async {
    final earning = double.tryParse(value);
    if (earning != null && earning > 0) {
      final updatedList = List<double>.from(state.dailyEarnings)..add(earning);
      final cappedList = updatedList.length > 500 ? updatedList.sublist(1) : updatedList;

      state = state.copyWith(
        dailyEarnings: cappedList,
        totalEarnings: state.totalEarnings + earning,
      );
    }
  }
}

// This is your provider
final earningsProvider = StateNotifierProvider<EarningsController, EarningsState>((ref) {
  return EarningsController();
});
