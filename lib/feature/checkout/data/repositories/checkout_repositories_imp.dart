import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';

import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/checkout/data/data/remote_data_source_checkout.dart';
import 'package:fashion/feature/checkout/data/models/card_model.dart';
import 'package:fashion/feature/checkout/data/models/location_model.dart';

import 'package:fashion/feature/checkout/domin/entity/checkout_entities.dart';

import '../../domin/repositories/checkout_repositories.dart';

class CheckoutRepositoriesImp extends CheckoutRepositories {
  final NetworkInfo networkInfo;
  final RemoteDataSourceCheckout remoteData;
  CheckoutRepositoriesImp(this.networkInfo, this.remoteData);
  @override
  Future<Either<Failure, CardEntity>> getDefaultCard(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final defaultCard = await remoteData.getDefaultCart(userID);
        return Right(defaultCard);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getDefaultLocation(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final defaultLocation = await remoteData.getDefaultLocation(userID);
        return Right(defaultLocation);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CardEntity>>> getAllCard(int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final listCardEntity = await remoteData.getAllCard(userID);
        return Right(listCardEntity);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getAllLocation(
      int userID) async {
    if (await networkInfo.isConnected) {
      try {
        final listLocationEntity = await remoteData.getAllLocation(userID);
        return Right(listLocationEntity);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addCard(CardEntity card) async {
    final CardModel cardModel = CardModel(
      id: card.id,
      userID: card.userID,
      paymentMethod: card.paymentMethod,
      cardLast4: card.cardLast4,
      cardBrand: card.cardBrand,
      isDefault: card.isDefault,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteData.addCard(cardModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addLocation(LocationEntity location) async {
    final LocationModel locationModel = LocationModel(
      locationID: location.locationID,
      userID: location.userID,
      longitude: location.longitude,
      latitude: location.latitude,
      addressName: location.addressName,
      fullAddress: location.fullAddress,
      defultAddress: location.defultAddress,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteData.addLocation(locationModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addCoupon(String couponName) async {
    if (await networkInfo.isConnected) {
      try {
        final discount = await remoteData.addCoupon(couponName);
        return Right(discount);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addOrder(
    int userID,
    int locationID,
    String payment,
    int discount,
    int totalPrice,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteData.addOrder(
          userID,
          locationID,
          payment,
          discount,
          totalPrice,
        );
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
