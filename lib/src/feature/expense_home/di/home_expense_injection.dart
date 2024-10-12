import 'package:todo_assesment/core/constant/global_constant.dart';

import '../data/repository/home_expense_repository_impl.dart';
import '../data/source/local/home_expense_source_impl.dart';
import '../domain/use_case/home_expense_usecase.dart';

class HomeExpenseInjection {
  static injectHomeTodo() {
    sl.registerSingleton(HomeExpenseSourceImpl());
    sl.registerSingleton(
        HomeExpenseRepositoryImpl(sl.get<HomeExpenseSourceImpl>()));
    _putUseCase();
  }

  static void _putUseCase() {
    sl.registerSingleton(HomeExpenseUseCase(
        repositoryImpl: sl.get<HomeExpenseRepositoryImpl>()));
  }
}
