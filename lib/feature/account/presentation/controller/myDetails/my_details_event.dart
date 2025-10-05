part of 'my_details_bloc.dart';

sealed class MyDetailsEvent extends Equatable {
  const MyDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpDateMyDetailsEvent extends MyDetailsEvent {
  final MyDetailsEntity myDetails;
  final String userImage;
  const UpDateMyDetailsEvent(this.myDetails, this.userImage);
  @override
  List<Object> get props => [myDetails, userImage];
}

class ValidTextFormFieldEvent extends MyDetailsEvent {
  final bool valid;
  const ValidTextFormFieldEvent(this.valid);
  @override
  List<Object> get props => [valid];
}

class ChoosYourCountryEvent extends MyDetailsEvent {
  // final Country country;
  final String flagEmoji;
  final String phoneCode;
  const ChoosYourCountryEvent(this.flagEmoji, this.phoneCode);
  @override
  List<Object> get props => [flagEmoji, phoneCode];
}
