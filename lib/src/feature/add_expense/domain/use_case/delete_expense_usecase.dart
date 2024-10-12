import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/core/base/use_case.dart';
import 'package:todo_assesment/src/feature/add_expense/data/repository/add_expense_repository_impl.dart';

class DeleteExpenseUseCase extends UseCase<Success, String> {
  final AddExpenseRepositoryImpl repositoryImpl;

  DeleteExpenseUseCase({required this.repositoryImpl});

  @override
  Future<Either<Failure, Success>> call(String param) async {
    return await repositoryImpl.deleteExpense(param);
  }
}
