import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizationn {
  final Locale? locale;

  AppLocalizationn({
    required this.locale,
  });

  static AppLocalizationn? of(BuildContext context) {
    return Localizations.of<AppLocalizationn>(context, AppLocalizationn);
  }

  static const LocalizationsDelegate<AppLocalizationn> delegate =
      _AppLocalizationDelegate();

  late Map<String, String> _localizedString;

  Future loadJsonLanguage() async {
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedString[key] ?? "";
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizationn> {
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizationn> load(Locale locale) async {
    AppLocalizationn appLocalizations = AppLocalizationn(locale: locale);
    await appLocalizations.loadJsonLanguage();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizationn> old) =>
      false;
}

extension TanslateX on String {
  String tr(BuildContext context) {
    return AppLocalizationn.of(context)!.translate(this);
  }
}
