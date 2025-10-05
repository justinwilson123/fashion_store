import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../injiction_container.dart' as di;

import '../themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ChangeThemeState(Themes().ligthTheme, "light")) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetThemeEvent) {
        final ThemeData themeData = await Themes().returnThemeMode();
        final themeName = await Themes().returnThemeName();
        emit(ChangeThemeState(themeData, themeName));
      } else if (event is ChangeThemeEvent) {
        await Themes().changeTheme(event.themeMode);

        ThemeData themeData = await Themes().returnThemeMode();
        final themeName = await Themes().returnThemeName();
        emit(ChangeThemeState(themeData, themeName));
      }
    });
  }
}
