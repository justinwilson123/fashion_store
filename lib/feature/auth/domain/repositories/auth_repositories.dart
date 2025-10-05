import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/users.dart';

abstract class AuthRepositories {
  Future<Either<Failure, Unit>> signUp(UserEntite user, File? image);
  Future<Either<Failure, Unit>> verifiUserEmail(
      String email, String verifiCode);

  Future<Either<Failure, Unit>> reSendVerifiCode(String email);

  Future<Either<Failure, Unit>> enterEmail(String email);
  Future<Either<Failure, Unit>> verifiEmailPass(
      String email, String verifiCode);
  Future<Either<Failure, Unit>> resetPassWord(String email, String password);

  Future<Either<Failure, UserEntite>> logIn(String email, String password);
  Future<Either<Failure, Unit>> signUpWithGoogle(UserEntite user, File? image);
  Future<Either<Failure, UserEntite>> loginWithGoogle(String email);
}
