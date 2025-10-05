import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/exception.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/core/services/network_info.dart';
import 'package:fashion/feature/home/data/data/local_data_source.dart';
import 'package:fashion/feature/home/data/data/remote_data_source_home.dart';
import 'package:fashion/feature/home/data/models/all_product_model.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/domain/ropositories/home_repository.dart';

typedef GetProductFromCrud = Future<List<ProductModel>> Function();

class HomeRepositoriesImp implements HomeRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSourceHome remoteDataSourceHome;
  final LocalDataSource localDataSource;
  HomeRepositoriesImp(
    this.networkInfo,
    this.remoteDataSourceHome,
    this.localDataSource,
  );
  @override
  Future<Either<Failure, List<CategoryEntiti>>> getCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSourceHome.getCategoreis();
        localDataSource.cachedCategories(categories);
        return Right(categories);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final categories = await localDataSource.getCachedCategories();
        return Right(categories);
      } on EmptyCachException {
        return Left(EmptyCachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProduct(
    int userID,
    int page,
  ) async {
    return await _getItems(
      () {
        return remoteDataSourceHome.getAllProduct(userID, page);
      },
      cachedProduct: true,
      getCachedProduct: true,
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(
    int userID,
    int categoryId,
    int page,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.getProduct(userID, categoryId, page);
    });
  }

  @override
  Future<Either<Failure, String>> getMaxPriceAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final maxPrice = await remoteDataSourceHome.getMaxPriceAllProduct();
        return Right(maxPrice);
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
  Future<Either<Failure, String>> getMaxPriceProduct(int gategoryID) async {
    if (await networkInfo.isConnected) {
      try {
        final maxPrice = await remoteDataSourceHome.getMaxPriceProduct(
          gategoryID,
        );
        return Right(maxPrice);
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
  Future<Either<Failure, List<ProductEntity>>> highLowPriceAllProduct(
    int userID,
    int page,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.highLowPriceAllProduct(userID, page);
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> lowHighPriceAllProduct(
    int userID,
    int page,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.lowHighPriceAllProduct(userID, page);
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> rangePriceAllProduct(
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.rangePriceAllProduct(
        userID,
        page,
        maxPrice,
        minPrice,
      );
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> highLowPriceProduct(
    int catogryID,
    int userID,
    int page,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.highLowPriceProduct(catogryID, userID, page);
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> lowHighPriceProduct(
    int catogryID,
    int userID,
    int page,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.lowHighPriceProduct(catogryID, userID, page);
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> rangPriceProduct(
    int catogryID,
    int userID,
    int page,
    int maxPrice,
    int minPrice,
  ) async {
    return await _getItems(() {
      return remoteDataSourceHome.rangePriceProduct(
        catogryID,
        userID,
        page,
        maxPrice,
        minPrice,
      );
    });
  }

  Future<Either<Failure, List<ProductEntity>>> _getItems(
    GetProductFromCrud getProductFromCrud, {
    bool cachedProduct = false,
    bool getCachedProduct = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await getProductFromCrud();
        if (cachedProduct) {
          localDataSource.cachedProducts(product);
        }
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      if (getCachedProduct) {
        try {
          final cachedAllProduct = await localDataSource.getCachedProducts();
          return Right(cachedAllProduct);
        } on EmptyCachException {
          return Left(EmptyCachFailure());
        }
      } else {
        return Left(OffLineFailure());
      }
    }
  }
}
