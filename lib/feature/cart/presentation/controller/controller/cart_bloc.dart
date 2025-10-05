import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/core/class/cached_user_info.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/cart/domain/usecase/add_one_piece_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/delete_all_piece_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/get_cart_usecase.dart';
import 'package:fashion/feature/cart/domain/usecase/remove_one_piece_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../../../injiction_container.dart' as di;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase getCart;
  final AddOnePieceUsecase addOnePiece;
  final RemoveOnePieceUsecase removeOnePiece;
  final DeleteAllPieceUsecase deleteAllPiece;
  static int sumItem = 0;
  CartBloc(
    this.getCart,
    this.addOnePiece,
    this.removeOnePiece,
    this.deleteAllPiece,
  ) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      final user = await di.sl<CachedUserInfo>().getUserInfo();
      if (event is GetCartEvent) {
        emit(
          state.copyWith(
            cartLoading: true,
            cart: [],
            errorMessage: "",
            successMessage: '',
          ),
        );
        final either = await getCart.call(user.userId!);
        either.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(cartLoading: false));
            } else {
              emit(
                state.copyWith(
                  cartLoading: false,
                  errorMessage: _mapFailureToMessage(failure),
                ),
              );
            }
          },
          (carts) {
            emit(
              state.copyWith(
                cartLoading: false,
                cart: carts,
                sumAllItemPrice: carts.fold(0, (pre, element) {
                  pre = pre! + element.sumPriceItem;
                  return pre;
                }),
              ),
            );
          },
        );
      } else if (event is RemoveOnePieceEvent) {
        final updatedCart = List<CartEntity>.from(state.cart);
        final index = updatedCart.indexWhere(
          (item) =>
              item.productID == event.productID &&
              item.colorID == event.colorID &&
              item.sizeID == event.sizedID,
        );
        if (index != -1 && state.cart[index].countItem > 0) {
          emit(state.copyWith(isAddRemoveDeleteLoading: true));
          final either = await removeOnePiece.call(
            event.productID,
            user.userId!,
            event.sizedID,
            event.colorID,
          );
          either.fold(
            (failure) {
              if (failure is NoDataFailure) {
                emit(state.copyWith(isAddRemoveDeleteLoading: false));
              } else {
                emit(
                  state.copyWith(
                    errorMessage: _mapFailureToMessage(failure),
                    isAddRemoveDeleteLoading: false,
                  ),
                );
              }
            },
            (_) {
              final updatedItem = updatedCart[index].copyWith(
                countItem: updatedCart[index].countItem - 1,
                sumPriceItem:
                    updatedCart[index].sumPriceItem -
                    updatedCart[index].productPrice,
              );
              updatedCart[index] = updatedItem;
              emit(
                state.copyWith(
                  isAddRemoveDeleteLoading: false,
                  cart: updatedCart,
                  sumAllItemPrice: updatedCart.fold(0, (pre, element) {
                    pre = pre! + element.sumPriceItem;
                    return pre;
                  }),
                ),
              );
            },
          );
        }
      } else if (event is AddOnePieceEvent) {
        emit(state.copyWith(isAddRemoveDeleteLoading: true));
        final updatedCart = List<CartEntity>.from(state.cart);
        final index = updatedCart.indexWhere(
          (item) =>
              item.productID == event.productID &&
              item.colorID == event.colorID &&
              item.sizeID == event.sizedID,
        );
        if (index != -1) {
          final either = await addOnePiece.call(
            producID: event.productID,
            price: event.price,
            userID: user.userId!,
            image: event.image,
            nameEn: event.nameEn,
            nameAr: event.nameAr,
            sizeID: event.sizedID,
            colorID: event.colorID,
          );
          either.fold(
            (failure) {
              if (failure is NoDataFailure) {
                emit(
                  state.copyWith(
                    isAddRemoveDeleteLoading: false,
                    errorMessage: "",
                    successMessage: "",
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    errorMessage: _mapFailureToMessage(failure),
                    isAddRemoveDeleteLoading: false,
                  ),
                );
              }
            },
            (_) {
              final updatedItem = updatedCart[index].copyWith(
                countItem: updatedCart[index].countItem + 1,
                sumPriceItem:
                    updatedCart[index].sumPriceItem +
                    updatedCart[index].productPrice,
              );
              updatedCart[index] = updatedItem;
              emit(
                state.copyWith(
                  isAddRemoveDeleteLoading: false,
                  cart: updatedCart,
                  sumAllItemPrice: updatedCart.fold(0, (pre, element) {
                    pre = pre! + element.sumPriceItem;
                    return pre;
                  }),
                ),
              );
            },
          );
        }
      } else if (event is DeleteAllPieceEvent) {
        emit(state.copyWith(isAddRemoveDeleteLoading: true));
        final ethier = await deleteAllPiece.call(
          event.productID,
          user.userId!,
          event.sizedID,
          event.colorID,
        );
        ethier.fold(
          (failure) {
            if (failure is NoDataFailure) {
              emit(state.copyWith(isAddRemoveDeleteLoading: false));
            } else {
              emit(
                state.copyWith(
                  errorMessage: _mapFailureToMessage(failure),
                  isAddRemoveDeleteLoading: false,
                ),
              );
            }
          },
          (_) {
            final updateCart = List.of(state.cart)
              ..removeWhere(
                (element) =>
                    element.productID == event.productID &&
                    element.colorID == event.colorID &&
                    element.sizeID == event.sizedID,
              );

            emit(
              state.copyWith(
                isAddRemoveDeleteLoading: false,
                cart: updateCart,
                sumAllItemPrice: updateCart.fold(0, (pre, element) {
                  pre = pre! + element.sumPriceItem;
                  return pre;
                }),
              ),
            );
          },
        );
      }
      sumItem = state.sumAllItemPrice;
    }, transformer: droppable());
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

//  final updatedItem = updatedCart[index].copyWith(
//                 countItem: updatedCart[index].countItem + 1,
//                 sumItem:
//                     updatedCart[index].sumPriceItem +
//                     updatedCart[index].productPrice,
//               );
//               updatedCart[index] = updatedItem;
//               emit(
//                 state.copyWith(
//                   isAddRemoveDeleteLoading: false,
//                   cart: updatedCart,
//                   sumAllItemPrice: updatedCart.fold(0, (pre, element) {
//                     pre = pre! + element.sumPriceItem;
//                     return pre;
//                   }),
//                 ),
//               );
//             },
          // );