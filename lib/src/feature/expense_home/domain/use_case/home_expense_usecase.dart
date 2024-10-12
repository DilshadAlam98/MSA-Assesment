import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/no_param.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/core/base/use_case.dart';

import '../../data/repository/home_expense_repository_impl.dart';

class HomeExpenseUseCase extends UseCase<Success, NoParam> {
  final HomeExpenseRepositoryImpl repositoryImpl;

  HomeExpenseUseCase({required this.repositoryImpl});

  @override
  Future<Either<Failure, Success>> call(NoParam param) async {
    return await repositoryImpl.getExpenses();
  }
}
