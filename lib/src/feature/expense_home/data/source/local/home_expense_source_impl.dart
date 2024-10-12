import 'package:todo_assesment/core/local/local_database.dart';
import 'package:todo_assesment/src/feature/expense_home/data/source/local/home_expense_source.dart';

import '../../../domain/model/res/expense_response.dart';

class HomeExpenseSourceImpl extends HomeExpenseSource with SqfLiteService {
  @override
  Future<List<ExpenseResponse>> getExpenses() async {
    return super.getFromDb().then((value) => value);
  }
}
