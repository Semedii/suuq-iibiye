import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieldValidators {
  static String? required(value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.requiredField;
    }
    return null;
  }

  static String? match(value1, value2, AppLocalizations localizations) {
    if (value1 == null || value1.isEmpty) {
      return localizations.requiredField;
    } else {
      if (value1 != value2) {
        return localizations.doesNotMatch;
      }
    }
    return null;
  }

  static String? fullName(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.requiredField;
    } else if (value.trim().split(' ').length < 2) {
      return localizations.businessName;
    }
    return null;
  }

  static String? password(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.requiredField;
    } else if (value.length < 6) {
      return localizations.passwordLengthValidation;
    }
    return null;
  }

  static String? checkbox(bool? value, AppLocalizations localizations) {
    if (value != null || value == false) {
      return localizations.termsValidation;
    }
    return null;
  }
}
