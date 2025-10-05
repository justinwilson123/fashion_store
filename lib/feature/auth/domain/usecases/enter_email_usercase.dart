import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class EnterEmailUsercase {
  final AuthRepositories authRepositories;
  EnterEmailUsercase(this.authRepositories);
  Future<Either<Failure, Unit>> call(String email) async {
    return await authRepositories.enterEmail(email);
  }
}
