import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/saved/domine/usecase/add_to_saved_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/get_saved_product_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/remove_all_saved_usecase.dart';
import 'package:fashion/feature/saved/domine/usecase/remove_from_saved_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domine/entity/saved_product_entity.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  int page = 0;
  final GetSavedProductUsecase savedProduct;
  final AddToSavedUsecase addToSaved;
  final RemoveFromSavedUsercase removeFromSaved;
  final RemoveAllSavedUsecase removeAllSaved;
  final CachedUserInfo cachedUserInfo;
  SavedBloc(
    this.savedProduct,
    this.addToSaved,
    this.removeFromSaved,
    this.removeAllSaved,
    this.cachedUserInfo,
  ) : super(SavedInitial()) {
    on<GetAllSavedProdutEvent>(
      (event, emit) async {
        if (state.hasRechedMax) return;
        page += 1;
        emit(state.copyWith(
            isLoading: true, errorMessage: "", successMessage: ""));
        final user = await cachedUserInfo.getUserInfo();
        final either = await savedProduct.call(user.userId!, page);
        either.fold(
          (failure) {
            print(failure);
            (failure is NoDataFailure)
                ? emit(state.copyWith(
                    isLoading: false,
                    errorMessage: "",
                    successMessage: "",
                    hasRechedMax: true))
                : emit(state.copyWith(
                    isLoading: false,
                    errorMessage: _mapFailureToMessage(failure),
                  ));
          },
          (product) {
            print(product);
            product.length >= 10
                ? emit(
                    state.copyWith(
                        isLoading: false,
                        errorMessage: "",
                        successMessage: "",
                        product: List.of(state.product)..addAll(product),
                        savedProduct: Map.of(state.savedProduct)
                          ..addAll(product.fold({}, (prev, elemnt) {
                            prev.addAll({elemnt.productId: 1});
                            return prev;
                          }))),
                  )
                : emit(state.copyWith(
                    isLoading: false,
                    errorMessage: "",
                    successMessage: "",
                    product: List.of(state.product)..addAll(product),
                    hasRechedMax: true,
                    savedProduct: Map.of(state.savedProduct)
                      ..addAll(product.fold({}, (prev, elemnt) {
                        prev.addAll({elemnt.productId: 1});
                        return prev;
                      }))));
          },
        );
      },
      transformer: droppable(),
    );
    on<AddToMapSavedEvent>((event, emit) {
      emit(state.copyWith(
          successMessage: "",
          errorMessage: "",
          savedProduct: Map.of(state.savedProduct)
            ..addAll(event.savedProduct)));
    }, transformer: droppable());
    on<RemoveFromSavedProductEvent>(
      (event, emit) async {
        emit(state.copyWith(
            product: List.of(state.product)
              ..removeWhere(
                  (element) => element.productId == event.productID)));
        final user = await cachedUserInfo.getUserInfo();
        final either =
            await removeFromSaved.call(user.userId!, event.productID);
        either.fold(
          (failure) {
            if (failure is OffLineFailure) {
              emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
            }
          },
          (_) {
            final newMap = Map.from(state.savedProduct);
            newMap[event.productID] = 0;
            emit(state.copyWith(
                savedProduct: newMap,
                successMessage: "Has been removed From favorite",
                errorMessage: ''));
          },
        );
        emit(state.copyWith(errorMessage: '', successMessage: ''));
      },
    );
    on<AddToSavedProductEvent>(
      (event, emit) async {
        emit(state.copyWith(successMessage: ""));
        final user = await cachedUserInfo.getUserInfo();
        final either = await addToSaved.call(user.userId!, event.productID);
        either.fold(
          (failure) {
            if (failure is OffLineFailure) {
              emit(state.copyWith(errorMessage: _mapFailureToMessage(failure)));
            }
          },
          (_) {
            final newMap = Map.from(state.savedProduct);
            newMap[event.productID] = 1;
            emit(state.copyWith(
                savedProduct: newMap,
                successMessage: "Has been Add to From favorite",
                errorMessage: ''));
          },
        );
        emit(state.copyWith(errorMessage: '', successMessage: ''));
      },
    );
    on<SavedEvent>(
      (event, emit) async {
        if (event is RefreshSavedProductEvent) {
          page = 0;
          emit(state.copyWith(
            product: [],
            hasRechedMax: false,
            errorMessage: "",
            successMessage: "",
          ));
          add(const GetAllSavedProdutEvent());
        }
      },
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




        // else if (event is RemoveFromSavedProductEvent) {
        //   emit(state.copyWith(
        //       successMessage: "",
        //       product: List.of(state.product)
        //         ..removeWhere(
        //             (element) => element.savedID == event.productID)));
        //   final user = await cachedUserInfo.getUserInfo();
        //   final either =
        //       await removeFromSaved.call(user.userId!, event.productID);
        //   either.fold(
        //     (failure) {
        //       if (failure is OffLineFailure) {
        //         emit(state.copyWith(
        //             errorMessage: _mapFailureToMessage(failure)));
        //       }
        //     },
        //     (_) {
        //       final newMap = Map.from(state.savedProduct);
        //       newMap[event.productID] = 0;
        //       emit(state.copyWith(
        //           savedProduct: newMap,
        //           successMessage: "Has been removed From favorite",
        //           errorMessage: ''));
        //     },
        //   );
        // } else if (event is AddToSavedProductEvent) {
        //   emit(state.copyWith(successMessage: ""));
        //   final user = await cachedUserInfo.getUserInfo();
        //   final either = await addToSaved.call(user.userId!, event.productID);
        //   either.fold(
        //     (failure) {
        //       if (failure is OffLineFailure) {
        //         emit(state.copyWith(
        //             errorMessage: _mapFailureToMessage(failure)));
        //       }
        //     },
        //     (_) {
        //       final newMap = Map.from(state.savedProduct);
        //       newMap[event.productID] = 1;
        //       emit(state.copyWith(
        //           savedProduct: newMap,
        //           successMessage: "Has been Add to From favorite",
        //           errorMessage: ''));
        //     },
        //   );
        // }





        //  else if (event is RemoveFromSavedProductEvent) {
        //   emit(state.copyWith(
        //       successMessage: "",
        //       product: List.of(state.product)
        //         ..removeWhere(
        //             (element) => element.savedID == event.productID)));
        //   final user = await cachedUserInfo.getUserInfo();
        //   final either =
        //       await removeFromSaved.call(user.userId!, event.productID);
        //   either.fold(
        //     (failure) {
        //       if (failure is OffLineFailure) {
        //         emit(state.copyWith(
        //             errorMessage: _mapFailureToMessage(failure)));
        //       }
        //     },
        //     (_) {
        //       final newMap = Map.from(state.savedProduct);
        //       newMap[event.productID] = 0;
        //       emit(state.copyWith(
        //           savedProduct: newMap,
        //           successMessage: "Has been removed From favorite",
        //           errorMessage: ''));
        //     },
        //   );
        // // }
        // else if (event is AddToSavedProductEvent) {
        //   emit(state.copyWith(successMessage: ""));
        //   final user = await cachedUserInfo.getUserInfo();
        //   final either = await addToSaved.call(user.userId!, event.productID);
        //   either.fold(
        //     (failure) {
        //       if (failure is OffLineFailure) {
        //         emit(state.copyWith(
        //             errorMessage: _mapFailureToMessage(failure)));
        //       }
        //     },
        //     (_) {
        //       final newMap = Map.from(state.savedProduct);
        //       newMap[event.productID] = 1;
        //       emit(state.copyWith(
        //           savedProduct: newMap,
        //           successMessage: "Has been Add to From favorite",
        //           errorMessage: ''));
        //     },
        //   );
        // }
