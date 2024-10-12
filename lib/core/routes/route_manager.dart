import 'package:flutter/material.dart';
import 'package:todo_assesment/core/routes/route_constant.dart';
import 'package:todo_assesment/src/feature/add_expense/presentations/pages/add_expense_screen.dart';

import '../../src/feature/expense_home/domain/model/res/expense_response.dart';

class RouteManager {
  static PageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConsts.addExpense:
        return MyCustomRoute(
          builder: (context) => const AddExpenseScreen(),
        );

      case RouteConsts.updateExpense:
        final arg = settings.arguments as ExpenseResponse?;
        return MyCustomRoute(
          builder: (context) => AddExpenseScreen(expense: arg),
        );
    }
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('404!!\nRoutes not found:=> ${settings.name}',
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({required super.builder, super.settings, this.transition})
      : super(fullscreenDialog: false);
  final Widget? transition;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return transition ?? FadeTransition(opacity: animation, child: child);
  }
}
