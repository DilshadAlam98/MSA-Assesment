import 'package:dartz/dartz.dart';
import 'package:todo_assesment/core/base/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}
