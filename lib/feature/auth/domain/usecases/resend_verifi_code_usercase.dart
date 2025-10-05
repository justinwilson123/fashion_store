import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class ResendVerifiCodeUsercase {
  final AuthRepositories authRepositories;
  ResendVerifiCodeUsercase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String email) async {
    return await authRepositories.reSendVerifiCode(email);
  }
}
