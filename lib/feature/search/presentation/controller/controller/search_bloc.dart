import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fashion/feature/search/domain/entity/search_entity.dart';
import 'package:fashion/feature/search/domain/usecase/cached_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/get_cach_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/get_result_use_case.dart';
import 'package:fashion/feature/search/domain/usecase/remove_one_cached_result_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/remove_all_cach_result_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetResultUseCase getResult;
  final GetCachResultUseCase getCachResult;
  final CachedResultUseCase cachedResult;
  final RemoveAllCachResultUseCase removeAllCached;
  final RemoveOneCachedResultUseCase removeOneCached;
  SearchBloc(
    this.getResult,
    this.getCachResult,
    this.cachedResult,
    this.removeAllCached,
    this.removeOneCached,
  ) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is GetCachedResultSearchEvent) {
        final either = await getCachResult.call();
        either.fold((failure) {}, (savedSearch) {
          emit(state.copyWith(fromCached: savedSearch));
        });
      } else if (event is GetResultSearchEvent) {
        emit(state.copyWith(nameProduct: event.name));
        if (event.name.isNotEmpty) {
          emit(state.copyWith(isLoading: true));
          final either = await getResult.call(event.name);
          either.fold(
            (failure) {
              emit(state.copyWith(isLoading: false, fromNetwork: []));
            },
            (result) {
              emit(state.copyWith(fromNetwork: result, isLoading: false));
            },
          );
        }
      } else if (event is AddReusltToCachedEevent) {
        final isNotFound = !state.fromCached.contains(event.searchEntity);
        // state.fromCached.
        if (isNotFound) {
          emit(
            state.copyWith(
              fromCached: List.of(state.fromCached)
                ..insert(0, event.searchEntity),
            ),
          );
          await cachedResult.call(state.fromCached);
        }
      } else if (event is RemoveAllCachedResultEvent) {
        if (state.fromCached.isNotEmpty) {
          emit(state.copyWith(fromCached: []));
          await removeAllCached.call();
        }
      } else if (event is RemoveOneResultFromCachedEvent) {
        emit(
          state.copyWith(
            fromCached: List.of(state.fromCached)..removeAt(event.index),
          ),
        );
        await removeOneCached.call(state.fromCached);
      }
    }, transformer: restartable());
  }
}
