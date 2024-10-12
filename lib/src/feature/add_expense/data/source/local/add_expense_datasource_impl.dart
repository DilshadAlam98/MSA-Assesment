import 'package:todo_assesment/core/local/local_database.dart';
import 'package:todo_assesment/src/feature/add_expense/data/source/local/add_expense_datasource.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

class AddExpenseSourceImpl extends AddExpenseSource with SqfLiteService {
  @override
  Future<bool> saveExpense(AddExpenseReq req) async {
    return await super.insertIntoDb(req);
  }

  @override
  Future<bool> deleteExpense(String id) async {
    return await super.deleteInDb(id: id);
  }

  @override
  Future<bool> updateExpense(AddExpenseReq req) async {
    return await super.updateInDb(req: req);
  }
}
