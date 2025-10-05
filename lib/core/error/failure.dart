import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OffLineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCachFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailNotCorrectFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailNotVerifitFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailUseingFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class PhoneNumberUseingFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class VerifiCodeNotCorrectFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotChooseAnyAccountFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailIsNotRegisteredFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class GoogleSignInFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class SomethingNotCorrectFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnExpactedFailure extends Failure {
  @override
  List<Object?> get props => [];
}
