import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

abstract class AddExpenseRepository {
  Future<Either<Failure, Success>> saveExpense(AddExpenseReq req);

  Future<Either<Failure, Success>> updateExpense(AddExpenseReq req);

  Future<Either<Failure, Success>> deleteExpense(String id);
}
