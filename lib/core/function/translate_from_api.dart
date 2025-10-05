import 'package:flutter/material.dart';

String translateFromApi(BuildContext context, String en, String ar) {
  String langCode = Localizations.localeOf(context).languageCode;
  if (langCode == "ar") {
    return ar;
  } else {
    return en;
  }
}
