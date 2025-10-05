import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../class/change_locale.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) async {
      if (event is GetCurrentLangEvent) {
        final String langCode = await ChangeLocale().getLocale();
        emit(state.copyWith(langCode: langCode));
      } else if (event is ChangeLangeEvent) {
        final String langCode = event.langCode;
        await ChangeLocale().saveLocale(langCode);
        emit(state.copyWith(langCode: langCode));
      }
    });
  }
}
