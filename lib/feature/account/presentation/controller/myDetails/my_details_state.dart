part of 'my_details_bloc.dart';

class MyDetailsState extends Equatable {
  final bool loadingUpdate;
  final String errorMessage;
  final String successMessage;
  final String flagEmoji;
  final String phoneCode;
  const MyDetailsState({
    this.loadingUpdate = false,
    this.errorMessage = '',
    this.successMessage = '',
    this.phoneCode = "963",
    this.flagEmoji = "🇸🇾",
  });

  MyDetailsState copyWith({
    bool? loadingUpdate,
    String? errorMessage,
    String? successMessage,
    String? flagEmoji,
    String? phoneCode,
  }) {
    return MyDetailsState(
      loadingUpdate: loadingUpdate ?? this.loadingUpdate,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      phoneCode: phoneCode ?? this.phoneCode,
    );
  }

  @override
  List<Object> get props => [
        loadingUpdate,
        errorMessage,
        successMessage,
        flagEmoji,
        phoneCode,
      ];
}

final class MyDetailsInitial extends MyDetailsState {}

class ChoosYourCountryState extends MyDetailsState {
  final Country country;
  const ChoosYourCountryState(this.country);
  @override
  List<Object> get props => [country];
}
