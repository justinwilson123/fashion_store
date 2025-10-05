import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class ResetPasswordUsecase {
  final AuthRepositories authRepositories;
  ResetPasswordUsecase(this.authRepositories);
  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await authRepositories.resetPassWord(email, password);
  }
}
