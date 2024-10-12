import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assesment/core/constant/global_constant.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/add_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/delete_expense_usecase.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/use_case/update_expense_usecase.dart';
import 'package:todo_assesment/src/utils/common_utils.dart';
import 'package:uuid/uuid.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit({
    required this.addExpenseUseCase,
    required this.updateExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(const AddExpenseState());

  final AddExpenseUseCase addExpenseUseCase;
  final UpdateExpenseUseCase updateExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  String? validateAmount(String? title) {
    if (title == null || title.trim().isEmpty) {
      return "Please enter amount";
    }
    return null;
  }

  String? validateDate(String? date) {
    if (date == null || date.trim().isEmpty) {
      return "Please select date";
    }
    return null;
  }

  String? validateDesc(String? desc) {
    if (desc == null || desc.trim().isEmpty) {
      return "Please enter description";
    }
    return null;
  }

  String? validateCategory(String? category) {
    if (category == null || category.trim().isEmpty) {
      return "Please select category";
    }
    return null;
  }

  void onCategoryChange(String? category) {
    emit(state.copyWith(category: category));
  }

  Future<void> onSave({
    required String amount,
    required String date,
    required String description,
  }) async {
    emit(state.copyWith(apistate: APISTATE.loading));
    final req = AddExpenseReq(
      date: DateTime.now().toString(),
      description: description.trim(),
      amount: amount,
      category: state.category,
      id: const Uuid().v1(),
    );

    final data = await addExpenseUseCase.call(req);
    data.fold(
      (l) {
        emit(state.copyWith(apistate: APISTATE.error));
        CommonUtils.showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(apistate: APISTATE.loaded));
        CommonUtils.showSuccessToast(r.message);
        goBack(arg: true);
      },
    );
  }

  Future<void> onUpdateExpense(AddExpenseReq param) async {
    emit(state.copyWith(apistate: APISTATE.loading));
    final data = await updateExpenseUseCase.call(param);
    data.fold(
      (l) {
        emit(state.copyWith(apistate: APISTATE.error));
        CommonUtils.showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(apistate: APISTATE.loaded));
        CommonUtils.showSuccessToast(r.message);
        goBack(arg: true);
      },
    );
  }

  Future<void> onDeleteExpense(String id) async {
    emit(state.copyWith(apistate: APISTATE.loading));
    final data = await deleteExpenseUseCase.call(id);
    data.fold(
      (l) {
        emit(state.copyWith(apistate: APISTATE.error));
        CommonUtils.showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(apistate: APISTATE.loaded));
        CommonUtils.showSuccessToast(r.message);
        goBack(arg: true);
      },
    );
  }
}
