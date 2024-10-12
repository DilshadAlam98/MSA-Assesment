import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/src/feature/add_expense/data/repository/add_expense_repository_impl.dart';
import 'package:todo_assesment/src/feature/add_expense/data/source/local/add_expense_datasource_impl.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/add_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/delete_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/update_expense_usecase.dart';

class AddExpenseInjection {
  static injectAddTodo() {
    sl.registerSingleton(AddExpenseSourceImpl());
    sl.registerSingleton(
        AddExpenseRepositoryImpl(sourceImpl: sl.get<AddExpenseSourceImpl>()));

    /// Use Cases
    _putUseCase();
  }

  static void _putUseCase() {
    sl.registerSingleton<AddExpenseUseCase>(AddExpenseUseCase(
        addExpenseRepositoryImpl: sl.get<AddExpenseRepositoryImpl>()));

    sl.registerSingleton(UpdateExpenseUseCase(
        repositoryImpl: sl.get<AddExpenseRepositoryImpl>()));

    sl.registerSingleton(DeleteExpenseUseCase(
        repositoryImpl: sl.get<AddExpenseRepositoryImpl>()));
  }
}
