import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';
import 'package:todo_assesment/core/base/success.dart';
import 'package:todo_assesment/core/base/use_case.dart';
import 'package:todo_assesment/src/feature/add_expense/data/repository/add_expense_repository_impl.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

class AddExpenseUseCase extends UseCase<Success, AddExpenseReq> {
  final AddExpenseRepositoryImpl addExpenseRepositoryImpl;

  AddExpenseUseCase({required this.addExpenseRepositoryImpl});

  @override
  Future<Either<Failure, Success>> call(AddExpenseReq param) async {
    return await addExpenseRepositoryImpl.saveExpense(param);
  }
}
