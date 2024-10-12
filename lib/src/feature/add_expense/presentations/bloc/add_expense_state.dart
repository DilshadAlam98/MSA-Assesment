part of 'add_expense_cubit.dart';

class AddExpenseState extends Equatable {
  final APISTATE apistate;
  final String? category;

  const AddExpenseState({this.apistate = APISTATE.idle, this.category});

  AddExpenseState copyWith({
    final APISTATE? apistate,
    final String? category,
  }) {
    return AddExpenseState(
      apistate: apistate ?? this.apistate,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        apistate,
        category,
      ];
}
