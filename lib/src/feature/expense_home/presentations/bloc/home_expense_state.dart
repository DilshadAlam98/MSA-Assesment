part of 'home_expense_cubit.dart';

class HomeExpenseState extends Equatable {
  final APISTATE apistate;
  final List<ExpenseResponse>? expenses;
  final String monthExpenses;
  final String weekExpenses;
  final FilterRequest? filterRequest;

  const HomeExpenseState({
    this.apistate = APISTATE.idle,
    this.expenses,
    this.monthExpenses = "",
    this.weekExpenses = "",
    this.filterRequest,
  });

  HomeExpenseState copyWith({
    final APISTATE? apistate,
    final List<ExpenseResponse>? expenses,
    final String? monthExpenses,
    final String? weekExpenses,
    final FilterRequest? filterRequest,
  }) {
    return HomeExpenseState(
      apistate: apistate ?? this.apistate,
      expenses: expenses ?? this.expenses,
      monthExpenses: monthExpenses ?? this.monthExpenses,
      weekExpenses: weekExpenses ?? this.weekExpenses,
      filterRequest: filterRequest,
    );
  }

  @override
  List<Object?> get props => [
        apistate,
        expenses,
        weekExpenses,
        monthExpenses,
        filterRequest,
      ];
}
