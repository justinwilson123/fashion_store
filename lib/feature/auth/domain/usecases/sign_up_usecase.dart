import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/users.dart';
import '../repositories/auth_repositories.dart';

class SignUpUsecase {
  final AuthRepositories authRepositories;
  SignUpUsecase(this.authRepositories);

  Future<Either<Failure, Unit>> call(UserEntite user, [File? image]) async {
    return await authRepositories.signUp(user, image);
  }
}
