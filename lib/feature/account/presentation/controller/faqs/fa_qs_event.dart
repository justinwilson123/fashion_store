part of 'fa_qs_bloc.dart';

sealed class FaQsEvent extends Equatable {
  const FaQsEvent();

  @override
  List<Object> get props => [];
}

class GetGenralFAQsEvent extends FaQsEvent {
  const GetGenralFAQsEvent();
  @override
  List<Object> get props => [];
}

class ChangeIndexEvent extends FaQsEvent {
  final int index;
  final String topic;
  const ChangeIndexEvent(this.index, this.topic);
  @override
  List<Object> get props => [index, topic];
}

class GetTopicFAQsEvent extends FaQsEvent {
  const GetTopicFAQsEvent();
  @override
  List<Object> get props => [];
}

class GetSearchFAQsEvent extends FaQsEvent {
  final String search;
  const GetSearchFAQsEvent(this.search);
  @override
  List<Object> get props => [search];
}
