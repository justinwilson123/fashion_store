import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/users.dart';
import '../repositories/auth_repositories.dart';

class LogInUsercase {
  final AuthRepositories authRepositories;
  LogInUsercase(this.authRepositories);
  Future<Either<Failure, UserEntite>> call(
      String email, String password) async {
    return await authRepositories.logIn(email, password);
  }
}
