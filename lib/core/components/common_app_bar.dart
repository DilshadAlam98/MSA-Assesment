import 'package:flutter/material.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/core/theme/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key, required this.title, this.actions, this.backgroundColor});

  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: backgroundColor,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
