import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/entities/my_details_entity.dart';

abstract class MyDetailsRepositiories {
  Future<Either<Failure, Unit>> upDateDetails(MyDetailsEntity details);
}
