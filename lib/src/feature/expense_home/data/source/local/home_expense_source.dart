import 'package:todo_assesment/src/feature/expense_home/domain/model/res/expense_response.dart';

abstract class HomeExpenseSource {
  Future<List<ExpenseResponse>> getExpenses();
}
