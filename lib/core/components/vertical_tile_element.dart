import 'package:flutter/material.dart';

import '../theme/app_textstyle.dart';

class VerticalTileElement extends StatelessWidget {
  const VerticalTileElement({
    super.key,
    required this.child,
    required this.label,
    this.isRequired = true,
  });

  final Widget child;
  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Row(
        children: [
          Text(label, style: AppTextStyle.body.medium.semiBold),
          if (isRequired) ...[
            Text(
              " *",
              style: AppTextStyle.body.medium.red,
            )
          ],
        ],
      ),
      subtitle: child,
    );
  }
}
