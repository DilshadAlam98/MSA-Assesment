import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_assesment/core/components/app_button.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/core/entity/date_entity.dart';
import 'package:todo_assesment/core/theme/app_colors.dart';
import 'package:todo_assesment/src/feature/expense_home/domain/model/req/fileter_request.dart';

import '../../core/components/app_textfield.dart';
import '../../core/components/primary_dropdown.dart';
import '../../core/components/vertical_tile_element.dart';
import '../../core/theme/app_textstyle.dart';

class CommonUtils {
  static void showSuccessToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: AppColors.teal,
      textColor: AppColors.white,
    );
  }

  static void showErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  static Future<DateEntity?> pickDate() async {
    final date = await showDatePicker(
      context: navigatorKey.currentState!.context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (date == null) return null;
    return DateEntity(
      date: date.toString(),
      formatedDate: DateFormat("dd MMM yyyy").format(date!),
      dateTime: date,
    );
  }

  static Future<void> showFilterSheet({
    required FilterRequest? filterRequest,
    required VoidCallback onReset,
    required Function(FilterRequest req) onSave,
  }) async {
    final filterDate =
        TextEditingController(text: filterRequest?.dateEntity?.formatedDate);
    DateEntity? dateEntity = filterRequest?.dateEntity;
    String? category = filterRequest?.category;
    await showModalBottomSheet(
      context: navigatorKey.currentState!.context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Filter Expenses", style: AppTextStyle.display.medium),
              const Divider(),
              VerticalTileElement(
                label: "Select Category",
                child: PrimaryDropdown<String>(
                  selected: category,
                  items: ["Food", "Medical", "Other"]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: AppTextStyle.title.small.black),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    category = value;
                  },
                ),
              ),
              VerticalTileElement(
                label: "Date",
                child: AppTextField(
                  controller: filterDate,
                  hintText: "Please select date",
                  readOnly: true,
                  onTap: () async {
                    final date = await CommonUtils.pickDate();
                    dateEntity = date;
                    filterDate.text = date!.formatedDate;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                    child: AppButton(
                      text: "Reset",
                      backgroundColor: AppColors.red,
                      onPressed: () {
                        onReset.call();
                        goBack();
                      },
                    ),
                  ),
                  const SizedBox(width: 25),
                  Flexible(
                    child: AppButton(
                      text: "Save",
                      onPressed: () {
                        onSave.call(FilterRequest(
                            category: category, dateEntity: dateEntity));
                        goBack();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
