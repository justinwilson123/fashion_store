import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/product_details/domain/usecase/add_to_cart_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/colors_usecase.dart';
import 'package:fashion/feature/product_details/domain/usecase/size_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entity/details_entities.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final SizesUsecase sizeUsecase;
  final ColorsUsecase colorsUsecase;
  final AddToCartUsecase addToCart;
  final CachedUserInfo cachedUserInfo;
  ProductDetailsBloc(
    this.sizeUsecase,
    this.colorsUsecase,
    this.addToCart,
    this.cachedUserInfo,
  ) : super(const ProductDetailsState()) {
    on<ProductDetailsEvent>(
      (event, emit) async {
        if (event is GetSizesProductEvent) {
          emit(state.copyWith(
            sizeIsLoading: true,
            errorMessage: "",
            successMessage: "",
          ));
          final either = await sizeUsecase.call(event.productID);
          either.fold(
            (failure) {
              if (failure is NoDataFailure) {
                emit(state.copyWith(
                  errorMessage: "",
                  sizeIsLoading: false,
                  successMessage: "",
                ));
              } else {
                emit(state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  successMessage: "",
                  sizeIsLoading: false,
                ));
              }
            },
            (sizes) {
              emit(state.copyWith(
                sizes: sizes,
                sizeIsLoading: false,
                successMessage: "",
                errorMessage: '',
              ));
            },
          );
        } else if (event is GetColorsProductEvent) {
          emit(state.copyWith(
            colors: [],
            colorIsLoading: true,
            selectColor: 1000,
            isSelectColor: false,
            selectSized: event.indexSelected,
            sizeID: 0,
            colorID: 0,
            successMessage: '',
            errorMessage: '',
          ));
          final either =
              await colorsUsecase.call(event.productID, event.sizeID);
          either.fold(
            (failure) {
              if (failure is NoDataFailure) {
                emit(state.copyWith(
                  errorMessage: "",
                  colorIsLoading: false,
                  successMessage: "",
                ));
              } else {
                emit(state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  successMessage: "",
                  colorIsLoading: false,
                ));
              }
            },
            (colors) {
              emit(state.copyWith(
                colors: colors,
                colorIsLoading: false,
                successMessage: "",
                errorMessage: '',
                isSelectSize: true,
                sizeID: event.sizeID,
              ));
            },
          );
        } else if (event is ChooseColorProductEvent) {
          emit(state.copyWith(
              selectColor: event.indexColorChoose,
              isSelectColor: true,
              colorID: event.colorID));
        } else if (event is AddToCartEvent) {
          emit(state.copyWith(
              cartLoading: true, errorMessage: "", successMessage: ""));
          final user = await cachedUserInfo.getUserInfo();
          final either = await addToCart.call(
            producID: event.producID,
            price: event.price,
            userID: user.userId!,
            image: event.image,
            nameEn: event.nameEn,
            nameAr: event.nameAr,
            sizeID: event.sizeID,
            colorID: event.colorID,
          );
          either.fold(
            (failure) {
              emit(state.copyWith(
                errorMessage: _mapFailureToMessage(failure),
                cartLoading: false,
              ));
            },
            (_) {
              emit(state.copyWith(
                  successMessage: "product has been Added to Your cart",
                  cartLoading: false));
            },
          );
        }
      },
      transformer: droppable(),
    );
  }
  String _mapFailureToMessage(Failure failure) {
    if (failure == ServerFailure()) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure == OffLineFailure()) {
      return OFFLINE_FAILURE_MESSAGE;
    } else {
      return "UnExpected Error , please try again later";
    }
  }
}
