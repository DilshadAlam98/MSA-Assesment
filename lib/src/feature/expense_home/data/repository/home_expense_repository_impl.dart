import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';

import '../../domain/repository/home_expense_repository.dart';
import '../source/local/home_expense_source_impl.dart';

class HomeExpenseRepositoryImpl implements HomeExpenseRepository {
  final HomeExpenseSourceImpl sourceImpl;

  HomeExpenseRepositoryImpl(this.sourceImpl);

  @override
  Future<Either<Failure, Success>> getExpenses() async {
    try {
      final result = await sourceImpl.getExpenses();
      return Right(
          Success(message: "Expenses fetched successfully", data: result));
    } catch (e) {
      return Left(Failure(message: "Something went wrong"));
    }
  }
}
