part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetCachedResultSearchEvent extends SearchEvent {
  const GetCachedResultSearchEvent();
  @override
  List<Object> get props => [];
}

class GetResultSearchEvent extends SearchEvent {
  final String name;
  const GetResultSearchEvent(this.name);
  @override
  List<Object> get props => [name];
}

class AddReusltToCachedEevent extends SearchEvent {
  final SearchEntity searchEntity;
  const AddReusltToCachedEevent(this.searchEntity);
  @override
  List<Object> get props => [searchEntity];
}

class RemoveAllCachedResultEvent extends SearchEvent {
  const RemoveAllCachedResultEvent();
  @override
  List<Object> get props => [];
}

class RemoveOneResultFromCachedEvent extends SearchEvent {
  final int index;
  const RemoveOneResultFromCachedEvent(this.index);
  @override
  List<Object> get props => [];
}
