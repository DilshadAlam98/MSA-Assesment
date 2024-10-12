import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_assesment/core/theme/app_colors.dart';
import 'package:todo_assesment/core/theme/app_textstyle.dart';

import '../../domain/model/res/expense_response.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.onTileClick,
    required this.expense,
  });

  final VoidCallback onTileClick;
  final ExpenseResponse? expense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTileClick.call();
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.black.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense?.description ?? "",
                      style: AppTextStyle.title.medium.white),
                  const SizedBox(height: 5),
                  Text(expense?.category ?? "",
                      style: AppTextStyle.title.small.white.ellipsis),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u{20B9}'
                    "${double.tryParse(expense?.amount ?? "") ?? ""}",
                    style: AppTextStyle.display.medium.white,
                  ),
                  Text(
                      DateFormat("dd MMM yyyy")
                          .format(DateTime.parse(expense?.date ?? "")),
                      style: AppTextStyle.title.small.white.ellipsis),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
