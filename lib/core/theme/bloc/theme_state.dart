part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

class ChangeThemeState extends ThemeState {
  final String themeName;
  final ThemeData themeData;
  const ChangeThemeState(this.themeData, this.themeName);
  @override
  List<Object> get props => [themeData, themeName];
}
