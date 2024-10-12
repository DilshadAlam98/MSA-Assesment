import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/core/base/no_param.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/src/feature/expense_home/domain/model/req/fileter_request.dart';
import 'package:todo_assesment/src/utils/common_utils.dart';

import '../../domain/model/res/expense_response.dart';
import '../../domain/use_case/home_expense_usecase.dart';

part 'home_expense_state.dart';

class HomeExpenseCubit extends Cubit<HomeExpenseState> {
  final HomeExpenseUseCase homeExpenseUseCase;

  HomeExpenseCubit({
    required this.homeExpenseUseCase,
  }) : super(const HomeExpenseState());

  void getTodos() async {
    emit(state.copyWith(expenses: [], apistate: APISTATE.loading));
    final data = await homeExpenseUseCase.call(NoParam());
    data.fold(
      (l) {
        emit(state.copyWith(apistate: APISTATE.error));
        CommonUtils.showErrorToast(l.message);
      },
      (r) {
        final weeklyExpenses = _getWeeklyExpenses(r.data);
        final monthlyExpenses = _getMonthlyExpenses(r.data);
        r.data.sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        emit(state.copyWith(
            apistate: APISTATE.loaded,
            expenses: r.data,
            weekExpenses: weeklyExpenses.toString(),
            monthExpenses: monthlyExpenses.toString(),
            filterRequest: null));
        CommonUtils.showSuccessToast(r.message);
      },
    );
  }

  void applyFilter(FilterRequest filter) {
    final expenses = state.expenses ?? [];
    final data = expenses
        .where((element) =>
            element.category == filter.category ||
            element.date == filter.dateEntity?.date)
        .toList();
    emit(state.copyWith(filterRequest: filter, expenses: data));
  }

  void resetFilter() {
    getTodos();
  }

  double _getWeeklyExpenses(List<ExpenseResponse> expenses) {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    double total = 0.0;

    for (var expense in expenses) {
      final expenseDate = DateTime.parse(expense.date);

      if (expenseDate.isAfter(startOfWeek) &&
          expenseDate.isBefore(now.add(const Duration(days: 1)))) {
        final amount = double.tryParse(expense.amount);
        total += amount ?? 0;
      }
    }

    return total;
  }

  double _getMonthlyExpenses(List<ExpenseResponse> expenses) {
    final DateTime now = DateTime.now();
    double total = 0.0;

    for (var expense in expenses) {
      final expenseDate = DateTime.parse(expense.date);
      if (expenseDate.month == now.month && expenseDate.year == now.year) {
        final amount = double.tryParse(expense.amount);
        total += amount ?? 0;
      }
    }

    return total;
  }
}
