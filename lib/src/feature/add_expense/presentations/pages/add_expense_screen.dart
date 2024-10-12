import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_assesment/core/components/app_button.dart';
import 'package:todo_assesment/core/components/app_textfield.dart';
import 'package:todo_assesment/core/components/common_app_bar.dart';
import 'package:todo_assesment/core/components/primary_dropdown.dart';
import 'package:todo_assesment/core/components/vertical_tile_element.dart';
import 'package:todo_assesment/core/entity/date_entity.dart';
import 'package:todo_assesment/core/theme/app_colors.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';
import 'package:todo_assesment/src/utils/common_utils.dart';

import '../../../../../core/theme/app_textstyle.dart';
import '../../../expense_home/domain/model/res/expense_response.dart';
import '../bloc/add_expense_cubit.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, this.expense});

  final ExpenseResponse? expense;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _amount = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  DateEntity? dateEntity;

  @override
  void initState() {
    _prefilledData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: getAppBarTitle()),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          children: [
            VerticalTileElement(
              label: "Amount",
              child: AppTextField(
                textInputType: TextInputType.number,
                controller: _amount,
                hintText: "Please enter amount",
                validator: (val) =>
                    context.read<AddExpenseCubit>().validateAmount(val),
              ),
            ),
            VerticalTileElement(
              label: "Date",
              child: AppTextField(
                controller: _dateController,
                hintText: "Please select date",
                readOnly: true,
                onTap: () async {
                  final date = await CommonUtils.pickDate();
                  dateEntity = date;
                  _dateController.text = date!.formatedDate;
                },
                validator: (val) =>
                    context.read<AddExpenseCubit>().validateDate(val),
              ),
            ),
            BlocBuilder<AddExpenseCubit, AddExpenseState>(
              builder: (context, state) {
                return VerticalTileElement(
                  label: "Select Category",
                  child: PrimaryDropdown<String>(
                    selected: state.category,
                    onChanged: (value) => context
                        .read<AddExpenseCubit>()
                        .onCategoryChange(value!),
                    validator: (value) =>
                        context.read<AddExpenseCubit>().validateCategory(value),
                    items: ["Food", "Medical", "Other"]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child:
                                Text(e, style: AppTextStyle.title.small.black),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            VerticalTileElement(
              label: "Description",
              child: AppTextField(
                controller: _descController,
                maxLines: 6,
                hintText: "Please enter description....",
                validator: (val) =>
                    context.read<AddExpenseCubit>().validateDesc(val),
              ),
            ),
            const SizedBox(height: 15),
            BlocBuilder<AddExpenseCubit, AddExpenseState>(
              builder: (context, state) {
                if (widget.expense != null) {
                  return Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          apistate: state.apistate,
                          backgroundColor: AppColors.red,
                          text: "Delete",
                          onPressed: () => onDeleteTodo(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AppButton(
                          apistate: state.apistate,
                          text: "Update",
                          onPressed: () => onUpdate(category: state.category),
                        ),
                      ),
                    ],
                  );
                }
                return AppButton(
                  apistate: state.apistate,
                  text: "Save",
                  onPressed: () => onSave(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getAppBarTitle() =>
      widget.expense != null ? "Update TODO" : "Add TODO";

  void onSave() {
    if (isValidate) {
      context.read<AddExpenseCubit>().onSave(
            amount: _amount.text,
            description: _descController.text,
            date: dateEntity!.date,
          );
    }
  }

  bool get isValidate => _formKey.currentState!.validate();

  void _prefilledData() {
    if (widget.expense == null) return;
    _amount.text = widget.expense?.amount ?? "";
    context.read<AddExpenseCubit>().onCategoryChange(widget.expense!.category);
    dateEntity = DateEntity(
        date: widget.expense!.date,
        formatedDate: DateFormat("dd MMM yyyy")
            .format(DateTime.parse(widget.expense!.date)),
        dateTime: DateTime.parse(widget.expense!.date));
    _dateController.text = dateEntity!.formatedDate;
    _descController.text = widget.expense?.description ?? "";
  }

  void onUpdate({String? category}) {
    final req = AddExpenseReq(
      amount: _amount.text.trim(),
      description: _descController.text.trim(),
      date: dateEntity?.date,
      id: widget.expense!.id,
      category: category,
    );

    context.read<AddExpenseCubit>().onUpdateExpense(req);
  }

  void onDeleteTodo() {
    context.read<AddExpenseCubit>().onDeleteExpense(widget.expense!.id!);
  }
}
