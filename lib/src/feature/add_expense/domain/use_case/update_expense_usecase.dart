import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/core/base/use_case.dart';
import 'package:todo_assesment/src/feature/add_expense/data/repository/add_expense_repository_impl.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

class UpdateExpenseUseCase extends UseCase<Success, AddExpenseReq> {
  UpdateExpenseUseCase({required this.repositoryImpl});

  final AddExpenseRepositoryImpl repositoryImpl;

  @override
  Future<Either<Failure, Success>> call(AddExpenseReq param) async {
    return await repositoryImpl.updateExpense(param);
  }
}
