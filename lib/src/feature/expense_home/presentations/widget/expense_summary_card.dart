import 'package:flutter/material.dart';
import 'package:todo_assesment/core/theme/app_textstyle.dart';

import '../../../../../core/theme/app_colors.dart';

class ExpenseSummaryCard extends StatelessWidget {
  const ExpenseSummaryCard(
      {super.key, required this.weeklyExpenses, required this.monthlyExpense});

  final String weeklyExpenses;
  final String monthlyExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Expense Summary:", style: AppTextStyle.title.large),
        Card(
          color: AppColors.teal,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("This Week", style: AppTextStyle.title.medium.white),
                    Text("\u{20B9} $weeklyExpenses",
                        style: AppTextStyle.title.medium.white),
                  ],
                ),
                const Divider(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("This Month", style: AppTextStyle.title.medium.white),
                    Text("\u{20B9} $monthlyExpense",
                        style: AppTextStyle.title.medium.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
