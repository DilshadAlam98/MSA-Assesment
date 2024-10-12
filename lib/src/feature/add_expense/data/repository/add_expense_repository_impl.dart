import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

import '../../domain/repository/add_expense_repository.dart';
import '../source/local/add_expense_datasource_impl.dart';

class AddExpenseRepositoryImpl implements AddExpenseRepository {
  final AddExpenseSourceImpl sourceImpl;

  AddExpenseRepositoryImpl({required this.sourceImpl});

  @override
  Future<Either<Failure, Success>> saveExpense(AddExpenseReq req) async {
    try {
      final result = await sourceImpl.saveExpense(req);
      return Right(
          Success(message: "Expense saved successfully", data: result));
    } catch (e) {
      return Left(Failure(message: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteExpense(String id) async {
    try {
      final data = await sourceImpl.deleteExpense(id);
      return Right(
          Success(message: "Expense deleted successfully", data: data));
    } catch (e) {
      return Left(Failure(message: "Failed to delete expense"));
    }
  }

  @override
  Future<Either<Failure, Success>> updateExpense(AddExpenseReq req) async {
    try {
      final data = await sourceImpl.updateExpense(req);
      return Right(
          Success(message: "Expenses updated successfully", data: data));
    } catch (e) {
      return Left(Failure(message: "Failed to update expense"));
    }
  }
}
