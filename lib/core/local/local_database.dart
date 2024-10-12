import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_assesment/src/feature/add_expense/domain/model/req/add_expense_request.dart';

import '../../src/feature/expense_home/domain/model/res/expense_response.dart';
import '../constant/app_constant.dart';

mixin class SqfLiteService {
  Future<Database> _initializeDb({AddExpenseReq? data}) async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, AppConstant.databaseName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE ${AppConstant.tableName}(${_createColumns(data?.toJson() ?? AddExpenseReq().toJson())})",
        );
      },
      version: 1,
    );
  }

  Future<bool> insertIntoDb(AddExpenseReq data) async {
    final db = await _initializeDb(data: data);
    final result = await db.insert(
      AppConstant.tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result == 1;
  }

  Future<List<ExpenseResponse>> getFromDb() async {
    final db = await _initializeDb();
    final data = await db.query(AppConstant.tableName);
    return data.map((e) => ExpenseResponse.fromJson(e)).toList();
  }

  Future<bool> updateInDb({required AddExpenseReq req}) async {
    final db = await _initializeDb();
    final data = await db.update(
      AppConstant.tableName,
      req.toJson(),
      where: 'id = ?',
      whereArgs: [req.id],
    );
    return data == 1;
  }

  Future<bool> deleteInDb({required String id}) async {
    final db = await _initializeDb();
    final data = await db.delete(
      AppConstant.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return data == 1;
  }

  String _createColumns(Map<dynamic, dynamic> map) {
    String column = ' ';
    map.forEach((key, value) {
      column += '$key ${getType(value.runtimeType)},';
    });
    final result =
        column.endsWith(',') ? column.substring(0, column.length - 2) : column;
    return result;
  }

  String getType(Type type) {
    switch (type) {
      case int:
        return "INTEGER";
      case String:
        return "TEXT";
      case double:
        return "REAL";
      case num:
        return "NUMERIC";
      case bool:
        return "BOOLEAN";
      default:
        return "TEXT";
    }
  }
}
