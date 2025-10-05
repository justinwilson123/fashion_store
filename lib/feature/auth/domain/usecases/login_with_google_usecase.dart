import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/users.dart';
import '../repositories/auth_repositories.dart';

class LoginWithGoogleUsecase {
  final AuthRepositories authRepositories;
  LoginWithGoogleUsecase(this.authRepositories);
  Future<Either<Failure, UserEntite>> call(String email) async {
    return await authRepositories.loginWithGoogle(email);
  }
}
