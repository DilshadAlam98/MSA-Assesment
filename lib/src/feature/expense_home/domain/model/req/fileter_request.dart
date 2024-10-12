import 'package:todo_assesment/core/entity/date_entity.dart';

class FilterRequest {
  final String? category;
  final DateEntity? dateEntity;

  FilterRequest({required this.category, required this.dateEntity});
}
