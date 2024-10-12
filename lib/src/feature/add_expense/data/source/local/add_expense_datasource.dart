import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

abstract class AddExpenseSource {
  Future<bool> saveExpense(AddExpenseReq req);

  Future<bool> updateExpense(AddExpenseReq req);

  Future<bool> deleteExpense(String id);
}
