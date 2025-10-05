import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:fashion/feature/account/domain/usecase/faqs/get_general_f_a_qs_usecase.dart';
import 'package:fashion/feature/account/domain/usecase/faqs/get_topic_f_a_qs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constant/strings/failure_message.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/faqs_entity.dart';
import '../../../domain/usecase/faqs/get_search_f_a_qs_usecase.dart';

part 'fa_qs_event.dart';
part 'fa_qs_state.dart';

class FaQsBloc extends Bloc<FaQsEvent, FaQsState> {
  final GetSearchFAQsUsecase getSearch;
  final GetGeneralFAQsUsecase getGeneral;
  final GetTopicFAQsUsecase getTopic;
  FaQsBloc(
    this.getGeneral,
    this.getSearch,
    this.getTopic,
  ) : super(FaQsInitial()) {
    // on<GetSearchFAQsEvent>(
    //   (event, emit) async {

    //     emit(state.copyWith(isLoading: true, fAQs: [], errorMessage: ""));
    //     final either = await getSearch.call(event.search);
    //     emit(_eitherFAQs(either));
    //   },
    //   transformer: restartable(),
    // );
    on<FaQsEvent>(
      (event, emit) async {
        if (event is GetGenralFAQsEvent) {
          emit(state.copyWith(
            isLoading: true,
            fAQs: [],
            errorMessage: "",
          ));
          final either = await getGeneral.call();
          emit(_eitherFAQs(either));
        } else if (event is GetSearchFAQsEvent) {
          emit(state.copyWith(
              searchLoading: true,
              searchFAQs: [],
              errorMessage: "",
              search: event.search));
          final either = await getSearch.call(event.search);
          either.fold(
            (failure) {
              print(failure);
              emit(state.copyWith(
                  searchLoading: false,
                  errorMessage: _mapFailureToMessage(failure)));
            },
            (searchFAQs) {
              print(searchFAQs);
              emit(
                  state.copyWith(searchLoading: false, searchFAQs: searchFAQs));
            },
          );
        } else if (event is GetTopicFAQsEvent) {
          emit(state.copyWith(isLoading: true, fAQs: [], errorMessage: ""));
          final either = await getTopic.call(state.topic);
          emit(_eitherFAQs(either));
        } else if (event is ChangeIndexEvent) {
          if (event.index == 0) {
            emit(state.copyWith(
                errorMessage: "",
                initIndex: event.index,
                topic: "",
                search: ""));
            add(const GetGenralFAQsEvent());
          } else {
            emit(state.copyWith(
                initIndex: event.index,
                errorMessage: "",
                topic: event.topic,
                search: ""));
            add(const GetTopicFAQsEvent());
          }
        }
      },
      transformer: restartable(),
    );
  }

  FaQsState _eitherFAQs(Either<Failure, List<FAQsEntity>> either) {
    return either.fold(
      (failure) {
        return state.copyWith(
            isLoading: false, errorMessage: _mapFailureToMessage(failure));
      },
      (fAQs) {
        return state.copyWith(isLoading: false, fAQs: fAQs, errorMessage: "");
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
