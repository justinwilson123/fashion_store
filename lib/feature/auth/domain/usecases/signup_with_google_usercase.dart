import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion/feature/auth/domain/entities/users.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class SignupWithGoogleUsercase {
  final AuthRepositories authRepositories;
  SignupWithGoogleUsercase(this.authRepositories);

  Future<Either<Failure, Unit>> call(UserEntite user, [File? image]) async {
    return await authRepositories.signUpWithGoogle(user, image);
  }
}
