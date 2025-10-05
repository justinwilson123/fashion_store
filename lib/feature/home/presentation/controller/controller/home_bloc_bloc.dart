import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/home/data/data/local_data_source.dart';
import 'package:fashion/feature/home/domain/usecase/get_all_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_category_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_max_price_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/get_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/high_low_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/high_low_price_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/low_high_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/low_high_price_product_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/range_price_allproduct_usecase.dart';
import 'package:fashion/feature/home/domain/usecase/range_price_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entiti/discove_entities.dart';
import '../../../domain/usecase/get_max_price_product_usecase.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeBlocState> {
  int pageAllProduct = 0;
  int pageProduct = 0;
  final GetCategoryUsecase getCategory;
  final GetProductUsecase getProduct;
  final GetAllProductUsecase getAllProduct;
  final CachedUserInfo userInfo;
  final LocalDataSource localDataSource;
  final GetMaxPriceUsecase maxPrice;
  final HighLowPriceAllproductUsecase highLowPriceAllproductUsecase;
  final LowHighPriceAllproductUsecase lowHighPriceAllproductUsecase;
  final RangePriceAllproductUsecase rangePriceAllproductUsecase;
  final HighLowPriceProductUsecase highLowPriceProductUsecase;
  final LowHighPriceProductUsecase lowHighPriceProductUsecase;
  final RangePriceProductUsecase rangePriceProductUsecase;
  final GetMaxPriceProductUsecase maxPriceProductUsecase;

  HomeBloc(
    this.getCategory,
    this.getAllProduct,
    this.userInfo,
    this.getProduct,
    this.localDataSource,
    this.maxPrice,
    this.highLowPriceAllproductUsecase,
    this.lowHighPriceAllproductUsecase,
    this.rangePriceAllproductUsecase,
    this.highLowPriceProductUsecase,
    this.lowHighPriceProductUsecase,
    this.rangePriceProductUsecase,
    this.maxPriceProductUsecase,
  ) : super(HomeInitial()) {
    on<GetAllProductEvent>((event, emit) async {
      if (state.hasReachedMax) return;
      pageAllProduct += 1;
      final user = await userInfo.getUserInfo();
      emit(state.copyWith(isAllProductLoading: true));

      if (!state.isAllProductFilter) {
        final either = await getAllProduct.call(user.userId!, pageAllProduct);
        emit(_eitherAllProduct(either));
      } else {
        if (state.initiIndexFilter == 0) {
          final either = await rangePriceAllproductUsecase.call(
            user.userId!,
            pageAllProduct,
            state.rangeValueEnd.round(),
            state.rangeValueStart.round(),
          );
          emit(_eitherAllProduct(either));
        } else if (state.initiIndexFilter == 1) {
          final either = await lowHighPriceAllproductUsecase.call(
            user.userId!,
            pageAllProduct,
          );
          emit(_eitherAllProduct(either));
        } else {
          final either = await highLowPriceAllproductUsecase.call(
            user.userId!,
            pageAllProduct,
          );
          emit(_eitherAllProduct(either));
        }
      }
    }, transformer: droppable());
    on<GetGategoreisEvent>((event, emit) async {
      emit(state.copyWith(isCategoriesLoading: true));
      final either = await getCategory.call();
      either.fold(
        (failure) {
          emit(
            state.copyWith(
              isCategoriesLoading: false,
              categories: [],
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (category) {
          emit(
            state.copyWith(
              isCategoriesLoading: false,
              categories: category,
              errorMessage: "",
            ),
          );
        },
      );
    });
    on<ChooseGategoryEvent>((event, emit) {
      event.currntIndex == 0
          ? add(const GetMaxPriceAllProductEvent())
          : add(const GetMaxPriceProductEvent());
      if (event.catergoryID != state.categoryID) {
        pageProduct = 0;
        emit(
          state.copyWith(
            errorMessage: "",
            initiIndex: event.currntIndex,
            categoryID: event.catergoryID,
            hasReachedMax1: false,
            product: [],
          ),
        );
      } else {
        emit(state.copyWith(initiIndex: event.currntIndex, errorMessage: ""));
      }
    });
    on<GetMaxPriceAllProductEvent>((event, emit) async {
      final either = await maxPrice.call();
      either.fold(
        (failure) {
          emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
        },
        (price) {
          emit(
            state.copyWith(
              endPrice: double.parse(price).toInt(),
              rangeValueEnd: double.parse(price),
              rangeValueStart: 0,
            ),
          );
        },
      );
    }, transformer: restartable());
    on<GetMaxPriceProductEvent>((event, emit) async {
      final either = await maxPriceProductUsecase.call(state.categoryID);
      either.fold(
        (failure) {
          emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
        },
        (price) {
          emit(
            state.copyWith(
              endPrice: double.parse(price).toInt(),
              rangeValueEnd: double.parse(price),
              rangeValueStart: 0,
            ),
          );
        },
      );
    }, transformer: restartable());
    on<AddRemoveFromMapSavedProductEvent>((event, emit) {
      final newMap = Map.from(state.savedProduct);
      newMap[event.productID] = event.value;
      emit(
        state.copyWith(
          savedProduct: newMap,
          errorMessage: "",
          successSaveRmoveToSaved: event.value == 0
              ? "has been added to favorit successfully"
              : "has been removed to favorit successfully",
        ),
      );
      // } else {
      //   emit(
      //     state.copyWith(
      //         savedProduct: Map.of(state.savedProduct)
      //           ..update(event.productID, (value) => value - 1)),
      //   );
      // }
    });
    on<GetProductEvent>((event, emit) async {
      if (state.hasReachedMax1) return;
      pageProduct += 1;
      final user = await userInfo.getUserInfo();
      emit(state.copyWith(isProductLoading: true, errorMessage: ""));

      if (!state.isProductFilter) {
        final either = await getProduct.call(
          user.userId!,
          state.categoryID,
          pageProduct,
        );
        emit(_eitherProduct(either));
      } else {
        if (state.initiIndexFilter == 0) {
          final either = await rangePriceProductUsecase.call(
            state.categoryID,
            user.userId!,
            pageProduct,
            state.rangeValueEnd.round(),
            state.rangeValueStart.round(),
          );
          emit(_eitherProduct(either));
        } else if (state.initiIndexFilter == 1) {
          final either = await lowHighPriceProductUsecase.call(
            state.categoryID,
            user.userId!,
            pageProduct,
          );
          emit(_eitherProduct(either));
        } else {
          final either = await highLowPriceProductUsecase.call(
            state.categoryID,
            user.userId!,
            pageProduct,
          );
          emit(_eitherProduct(either));
        }
      }
    }, transformer: droppable());
    on<ShowAndHideAppBar>((event, emit) {
      emit(state.copyWith(showHide: event.showHide));
    });
    on<HomeEvent>((event, emit) async {
      if (event is RangeSliderFilterEvent) {
        emit(
          state.copyWith(
            rangeValueStart: event.rangeValueStart,
            rangeValueEnd: event.rangeValueEnd,
            errorMessage: "",
          ),
        );
      } else if (event is ChooseFilterTypeEvent) {
        emit(
          state.copyWith(
            initiIndexFilter: event.currentIndex,
            errorMessage: "",
          ),
        );
      } else if (event is ApplayFilterEvnet) {
        if (state.initiIndex == 0) {
          pageAllProduct = 0;
          emit(
            state.copyWith(
              allProduct: [],
              hasReachedMax: false,
              isAllProductFilter: true,
              errorMessage: "",
            ),
          );
          add(const GetAllProductEvent());
        } else {
          pageProduct = 0;
          emit(
            state.copyWith(
              product: [],
              hasReachedMax1: false,
              isProductFilter: true,
              errorMessage: "",
            ),
          );
          add(const GetProductEvent());
        }
      }
    });
  }

  HomeBlocState _eitherProduct(Either<Failure, List<ProductEntity>> either) {
    return either.fold(
      (failure) {
        return (failure is NoDataFailure)
            ? state.copyWith(
                isProductLoading: false,
                hasReachedMax1: true,
                errorMessage: "",
              )
            : state.copyWith(
                isProductLoading: false,
                errorMessage: _mapFailureToMessage(failure),
              );
      },
      (product) {
        return product.length >= 10
            ? state.copyWith(
                isProductLoading: false,
                errorMessage: "",
                product: List.of(state.product)..addAll(product),
                savedProduct: Map.of(state.savedProduct)
                  ..addAll(
                    product.fold({}, (prev, elemnt) {
                      prev.addAll({elemnt.productId: elemnt.favorite});
                      return prev;
                    }),
                  ),
              )
            : state.copyWith(
                errorMessage: "",
                isProductLoading: false,
                product: List.of(state.product)..addAll(product),
                hasReachedMax1: true,
                savedProduct: Map.of(state.savedProduct)
                  ..addAll(
                    product.fold({}, (prev, elemnt) {
                      prev.addAll({elemnt.productId: elemnt.favorite});
                      return prev;
                    }),
                  ),
              );
      },
    );
  }

  HomeBlocState _eitherAllProduct(Either<Failure, List<ProductEntity>> either) {
    return either.fold(
      (failure) {
        return (failure is NoDataFailure)
            ? state.copyWith(
                isAllProductLoading: false,
                hasReachedMax: true,
                errorMessage: "",
              )
            : state.copyWith(
                isAllProductLoading: false,
                errorMessage: _mapFailureToMessage(failure),
              );
      },
      (allProduct) {
        return allProduct.length >= 10
            ? state.copyWith(
                errorMessage: "",
                isAllProductLoading: false,
                allProduct: List.of(state.allProduct)..addAll(allProduct),
                savedProduct: Map.of(state.savedProduct)
                  ..addAll(
                    allProduct.fold({}, (prev, elemnt) {
                      prev.addAll({elemnt.productId: elemnt.favorite});
                      return prev;
                    }),
                  ),
              )
            : state.copyWith(
                errorMessage: "",
                isAllProductLoading: false,
                allProduct: List.of(state.allProduct)..addAll(allProduct),
                hasReachedMax: true,
                savedProduct: Map.of(state.savedProduct)
                  ..addAll(
                    allProduct.fold({}, (prev, elemnt) {
                      prev.addAll({elemnt.productId: elemnt.favorite});
                      return prev;
                    }),
                  ),
              );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure is NoDataFailure) {
      return "";
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
