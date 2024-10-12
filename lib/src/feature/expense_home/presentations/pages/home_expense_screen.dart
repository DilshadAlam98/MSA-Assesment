import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/core/components/common_app_bar.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/core/routes/route_constant.dart';
import 'package:todo_assesment/core/theme/app_colors.dart';
import 'package:todo_assesment/src/feature/expense_home/presentations/widget/expense_summary_card.dart';

import '../../../../utils/common_utils.dart';
import '../../domain/model/res/expense_response.dart';
import '../bloc/home_expense_cubit.dart';
import '../widget/expense_tile.dart';

class HomeExpenseScreen extends StatefulWidget {
  const HomeExpenseScreen({super.key});

  @override
  State<HomeExpenseScreen> createState() => _HomeExpenseScreenState();
}

class _HomeExpenseScreenState extends State<HomeExpenseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeExpenseCubit>().getTodos();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Home",
        actions: [
          BlocBuilder<HomeExpenseCubit, HomeExpenseState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  await CommonUtils.showFilterSheet(
                    filterRequest: state.filterRequest,
                    onReset: () {
                      context.read<HomeExpenseCubit>().resetFilter();
                    },
                    onSave: (req) {
                      context.read<HomeExpenseCubit>().applyFilter(req);
                    },
                  );
                },
                icon: const Icon(Icons.flag_outlined),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddTodoClick(),
        child: const Icon(Icons.add, color: AppColors.white, size: 30),
      ),
      body: BlocBuilder<HomeExpenseCubit, HomeExpenseState>(
        builder: (context, state) {
          if (state.apistate == APISTATE.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.expenses == null || state.expenses!.isEmpty) {
            return const Center(
              child: Text("No Expenses found"),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                ExpenseSummaryCard(
                  monthlyExpense: state.monthExpenses,
                  weeklyExpenses: state.weekExpenses,
                ),
                const SizedBox(height: 15),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final expense = state.expenses?[index];
                    return ExpenseTile(
                      onTileClick: () => onUpdateTodoClick(expense),
                      expense: expense,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: state.expenses?.length ?? 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onAddTodoClick() async {
    final result = await push(RouteConsts.addExpense);
    if (result == true) {
      context.read<HomeExpenseCubit>().getTodos();
    }
  }

  void onUpdateTodoClick(ExpenseResponse? expense) async {
    final result = await push(RouteConsts.updateExpense, arg: expense);
    if (result == true) {
      context.read<HomeExpenseCubit>().getTodos();
    }
  }
}
