import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion/core/services/firebase_auth_service.dart';

import '../../../../core/constant/app_links.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/services/crud.dart';
import '../models/user_model.dart';

abstract class RemoteDataSourceAuth {
  Future<Unit> signUp(UserModel user, File? image);
  Future<Unit> verifiUserEmail(String email, String verifiCode);

  Future<Unit> reSendVerifiCode(String email);

  Future<Unit> enterEmail(String email);
  Future<Unit> verifiEmailPass(String email, String verifiCode);
  Future<Unit> resetPassWord(String email, String password);

  Future<UserModel> logIn(String email, String password);
  Future<UserModel> logInWithGoogle(String email);
  Future<Unit> signupWithGoogle(UserModel user, File? image);
}

class RemoteDataSourceAuthWithHttp implements RemoteDataSourceAuth {
  final Crud crud;
  final FirebaseAuthService authService;
  RemoteDataSourceAuthWithHttp(this.crud, this.authService);

  @override
  Future<Unit> enterEmail(String email) async {
    Map data = {"user_email": email};
    final resopnse = await crud.postData(AppLinks.enterEmailLink, data);
    if (resopnse["status"] == "success") {
      return Future.value(unit);
    } else {
      throw EmailNotCorrectException();
    }
  }

  @override
  Future<UserModel> logIn(String email, String password) async {
    Map data = {
      "user_email": email,
      "user_password": password,
    };
    final response = await crud.postData(AppLinks.logInLink, data);
    print(response['status']);
    if (response["status"] == "success") {
      final responseData = response["data"];
      return UserModel.fromJson(responseData);
    } else if (response['status'] == "emailNotRegist") {
      throw EmailIsNotRegisteredException();
    } else if (response["status"] == "emailpass") {
      throw EmailNotCorrectException();
    } else if (response['status'] == "notaprove") {
      throw EmailNotVerifiledException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> reSendVerifiCode(String email) async {
    final data = {
      "user_email": email,
    };
    final response = await crud.postData(AppLinks.reSendVerifiCodeLink, data);
    if (response["status"] == "success") {
      // print("++++++++++++++++++++++++++++++++===$response");
      return Future.value(unit);
    } else {
      throw EmailNotCorrectException();
    }
  }

  @override
  Future<Unit> resetPassWord(String email, String password) async {
    final data = {
      "user_email": email,
      "user_password": password,
    };
    final response = await crud.postData(AppLinks.resetPasswordLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw EmailNotCorrectException();
    }
  }

  @override
  Future<Unit> signUp(UserModel user, File? image) async {
    final data = user.toJson();

    final response =
        await crud.postDataWithFile(AppLinks.signUpLink, data, image);
    if (response["status"] == "usermail") {
      throw EmailUseingException();
    } else if (response["status"] == "userphone") {
      throw PhoneNumberUseingException();
    } else if (response['status'] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> verifiEmailPass(String email, String verifiCode) async {
    final data = {
      "user_email": email,
      "user_verifi_code": verifiCode,
    };
    final response = await crud.postData(AppLinks.verifiEmailLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw VerifiNotCorrectException();
    }
  }

  @override
  Future<Unit> verifiUserEmail(String email, String verifiCode) async {
    final data = {
      "user_verifi_code": verifiCode,
      "user_email": email,
    };
    final response = await crud.postData(AppLinks.verifiUserEmailLink, data);
    if (response["status"] == "success") {
      return Future.value(unit);
    } else {
      throw VerifiNotCorrectException();
    }
  }

  @override
  Future<UserModel> logInWithGoogle(String email) async {
    final data = {
      "user_email": email,
    };
    final response = await crud.postData(AppLinks.logInWithGoogleLink, data);
    if (response['status'] == "success") {
      final resposneData = response["data"];
      return UserModel.fromJson(resposneData);
    } else if (response['status'] == "emailNotRegist") {
      await authService.logoutGoogleAccounte();
      throw EmailIsNotRegisteredException();
    } else {
      await authService.loginWithgoole();
      throw ServerException();
    }
  }

  @override
  Future<Unit> signupWithGoogle(UserModel userModel, File? image) async {
    final data = {
      "user_email": userModel.userEmail,
      "user_full_name": userModel.userFullName,
    };
    final response = await crud.postDataWithFile(
      AppLinks.signUpWithGoogleLink,
      data,
      image,
    );
    if (response['status'] == "usermail") {
      await authService.logoutGoogleAccounte();
      throw EmailUseingException();
    } else if (response["status"] == "success") {
      await authService.logoutGoogleAccounte();
      return Future.value(unit);
    } else {
      await authService.logoutGoogleAccounte();
      throw ServerException();
    }
  }
}
