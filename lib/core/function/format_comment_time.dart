import "package:flutter/material.dart";
import "package:timeago/timeago.dart" as timeago;

String formatCommentTime(BuildContext context, DateTime time) {
  String langCode = Localizations.localeOf(context).languageCode;
  if (langCode == "en") {
    timeago.setLocaleMessages("en", timeago.EnMessages());
    return timeago.format(time, locale: "en");
  } else {
    timeago.setLocaleMessages("ar", timeago.ArMessages());
    return timeago.format(time, locale: "ar");
  }
}
