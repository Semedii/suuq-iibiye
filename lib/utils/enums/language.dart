import 'package:flutter/material.dart';

enum Language {
  somali,
  english,
}

Language getLanguageFromString(String language) {
  switch (language.toLowerCase()) {
    case 'somali':
      return Language.somali;
    case 'english':
      return Language.english;
    default:
      throw Exception('Unknown category: $Language');
  }
}

String languageToString(Language language) {
  switch (language) {
    case Language.somali:
      return 'somali';
    case Language.english:
      return 'english';
  }
}

Locale languageToLocale(Language language) {
  switch (language) {
    case Language.somali:
      return const Locale('es');
    case Language.english:
      return const Locale('en');
  }
}

Language localeToLangugae(Locale locale) {
  switch (locale.languageCode) {
    case 'es':
      return Language.somali;
    case 'en':
      return Language.english;
    default:
      return Language.somali;
  }
}

String localeToString(Locale locale){
   switch (locale.languageCode) {
    case 'es':
      return "Somali";
    case 'en':
      return "English";
    default:
      return "Somali";
  }
}

