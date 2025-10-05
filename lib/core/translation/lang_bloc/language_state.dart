part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String langCode;
  const LanguageState({
    this.langCode = "",
  });
  LanguageState copyWith({
    String? langCode,
  }) {
    return LanguageState(
      langCode: langCode ?? this.langCode,
    );
  }

  @override
  List<Object> get props => [langCode];
}

final class LanguageInitial extends LanguageState {}
