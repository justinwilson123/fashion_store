import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class VerifiEmailPassUsercase {
  final AuthRepositories authRepositories;
  VerifiEmailPassUsercase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String email, String verifiCode) async {
    return await authRepositories.verifiEmailPass(email, verifiCode);
  }
}
