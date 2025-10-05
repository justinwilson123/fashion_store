import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/entities/users.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../datasources/remote_data_source_auth.dart';
import '../models/user_model.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final RemoteDataSourceAuth remoteDataSourceAuth;
  final NetworkInfo networkInfo;
  AuthRepositoriesImp({
    required this.remoteDataSourceAuth,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> enterEmail(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.enterEmail(email);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntite>> logIn(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSourceAuth.logIn(email, password);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      } on EmailNotVerifiledException {
        return Left(EmailNotVerifitFailure());
      } on EmailIsNotRegisteredException {
        return Left(EmailIsNotRegisteredFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> reSendVerifiCode(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.reSendVerifiCode(email);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassWord(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.resetPassWord(email, password);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(UserEntite user, File? image) async {
    if (await networkInfo.isConnected) {
      final UserModel userModel = UserModel(
        userEmail: user.userEmail,
        userPhone: user.userPhone,
        userPassword: user.userPassword,
        userFullName: user.userFullName,
      );
      try {
        await remoteDataSourceAuth.signUp(userModel, image);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailUseingException {
        return Left(EmailUseingFailure());
      } on PhoneNumberUseingException {
        return Left(PhoneNumberUseingFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifiEmailPass(
      String email, String verifiCode) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.verifiEmailPass(email, verifiCode);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on VerifiNotCorrectException {
        return Left(VerifiCodeNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifiUserEmail(
      String email, String verifiCode) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.verifiUserEmail(email, verifiCode);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on VerifiNotCorrectException {
        return Left(VerifiCodeNotCorrectFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntite>> loginWithGoogle(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSourceAuth.logInWithGoogle(email);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      } on NotChooseAnyAccountException {
        return Left(NotChooseAnyAccountFailure());
      } on EmailIsNotRegisteredException {
        return Left(EmailIsNotRegisteredFailure());
      } on GoogleSignInException {
        return Left(GoogleSignInFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpWithGoogle(
      UserEntite user, File? image) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel = UserModel(
          userEmail: user.userEmail,
          userFullName: user.userFullName,
        );
        await remoteDataSourceAuth.signupWithGoogle(userModel, image);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on NotChooseAnyAccountException {
        return Left(NotChooseAnyAccountFailure());
      } on EmailUseingException {
        return Left(EmailUseingFailure());
      } on GoogleSignInException {
        return Left(GoogleSignInFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
