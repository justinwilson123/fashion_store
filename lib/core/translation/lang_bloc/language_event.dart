part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLangEvent extends LanguageEvent {
  @override
  List<Object> get props => [];
}

class ChangeLangeEvent extends LanguageEvent {
  final String langCode;

  const ChangeLangeEvent({required this.langCode});
  @override
  List<Object> get props => [langCode];
}
