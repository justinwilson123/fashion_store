import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class VerifiUserEmailUsercase {
  final AuthRepositories authRepositories;
  VerifiUserEmailUsercase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String email, String verifiCode) async {
    return await authRepositories.verifiUserEmail(email, verifiCode);
  }
}
