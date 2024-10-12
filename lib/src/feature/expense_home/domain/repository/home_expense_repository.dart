import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';

abstract class HomeExpenseRepository {
  Future<Either<Failure, Success>> getExpenses();
}
