part of 'add_card_bloc.dart';

class AddCardState extends Equatable {
  final String errorMessage;
  final String successMessage;
  final bool isLoading;
  final bool validCardNumder;
  final bool validPamentMethed;
  final bool validCardBrand;
  final bool isDefault;
  final bool validAll;

  const AddCardState({
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
    this.validCardNumder = false,
    this.validPamentMethed = false,
    this.validCardBrand = false,
    this.isDefault = false,
    this.validAll = false,
  });

  AddCardState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? validCardNumder,
    bool? validPamentMethed,
    bool? validCardBrand,
    bool? isDefault,
    bool? validAll,
  }) {
    return AddCardState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      validCardNumder: validCardNumder ?? this.validCardNumder,
      validPamentMethed: validPamentMethed ?? this.validPamentMethed,
      validCardBrand: validCardBrand ?? this.validCardBrand,
      isDefault: isDefault ?? this.isDefault,
      validAll: validAll ?? this.validAll,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        successMessage,
        isLoading,
        validCardNumder,
        validPamentMethed,
        validCardBrand,
        isDefault,
        validAll,
      ];
}

final class AddCardInitial extends AddCardState {}
