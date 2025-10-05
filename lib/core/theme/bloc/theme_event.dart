part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetThemeEvent extends ThemeEvent {
  const GetThemeEvent();
  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final String themeMode;
  const ChangeThemeEvent(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}
