import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_textstyle.dart';

class PrimaryDropdown<T> extends StatelessWidget {
  const PrimaryDropdown({
    super.key,
    this.selected,
    this.onChanged,
    required this.items,
    this.validator,
    this.hint = "Select",
    this.disableHint,
    this.fillColor,
    this.enableBorder = true,
  });

  final List<DropdownMenuItem<T>> items;
  final T? selected;
  final Function(T? value)? onChanged;
  final String? Function(T? value)? validator;
  final String? hint;
  final String? disableHint;
  final Color? fillColor;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      isDense: true,
      isExpanded: true,
      value: selected,
      items: items,
      onChanged: onChanged,
      disabledHint: Text(
        disableHint ?? "No data available",
        style: AppTextStyle.title.small,
      ),
      iconEnabledColor: AppColors.teal,
      autofocus: false,
      style: AppTextStyle.title.small,
      decoration: InputDecoration(
        border: !enableBorder ? InputBorder.none : null,
        enabled: true,
        fillColor: fillColor ?? AppColors.white,
        filled: true,
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: AppTextStyle.display.small,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        focusedErrorBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
        errorStyle: AppTextStyle.body.small.lightWeight.red.italic,
        errorBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1.5,
                  color: AppColors.red.withOpacity(0.5),
                ),
              )
            : null,
        focusedBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
        disabledBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1.5, color: AppColors.grey),
              )
            : null,
        enabledBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              )
            : null,
      ),
    );
  }
}
