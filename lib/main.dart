import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/src/feature/add_expense/di/add_expense_di.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/add_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/delete_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/update_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/presentations/bloc/add_expense_cubit.dart';
import 'package:todo_assesment/src/feature/expense_home/di/home_expense_injection.dart';
import 'package:todo_assesment/src/feature/expense_home/domain/use_case/home_expense_usecase.dart';
import 'package:todo_assesment/src/feature/expense_home/presentations/bloc/home_expense_cubit.dart';
import 'package:todo_assesment/src/feature/expense_home/presentations/pages/home_expense_screen.dart';

import 'core/config/notification_config.dart';
import 'core/constant/global_constant.dart';
import 'core/routes/route_manager.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  NotificationService.checkNotificationPermission();
  NotificationService().scheduleNotification();
  AddExpenseInjection.injectAddTodo();
  HomeExpenseInjection.injectHomeTodo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeExpenseCubit(
            homeExpenseUseCase: sl.get<HomeExpenseUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddExpenseCubit(
            addExpenseUseCase: sl.get<AddExpenseUseCase>(),
            deleteExpenseUseCase: sl.get<DeleteExpenseUseCase>(),
            updateExpenseUseCase: sl.get<UpdateExpenseUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteManager.onGenerateRoute,
        title: "Assessment",
        theme: AppTheme.getAppTheme(),
        home: const HomeExpenseScreen(),
      ),
    );
  }
}
