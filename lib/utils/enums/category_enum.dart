import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Category {
  clothes,
  shoes,
  homeAccessories,
  electronics,
  gymAccessories,
  kitchenAccessories,
  cosmetics,
  others,
}

Category getCategoryFromString(String categoryString) {
  switch (categoryString.toLowerCase()) {
    case 'clothes':
      return Category.clothes;
    case 'shoes':
      return Category.shoes;
    case 'home accessories':
      return Category.homeAccessories;
    case 'electronics':
      return Category.electronics;
    case 'gym accessories':
      return Category.gymAccessories;
    case 'kitchen accessories':
      return Category.kitchenAccessories;
    case 'cosmetics':
      return Category.cosmetics;
    default:
      return Category.others;
  }
}

String categoryToString(Category category) {
  switch (category) {
    case Category.clothes:
      return 'clothes';
    case Category.shoes:
      return 'shoes';
    case Category.homeAccessories:
      return 'home accessories';
    case Category.electronics:
      return 'electronics';
    case Category.gymAccessories:
      return 'gym accessories';
    case Category.kitchenAccessories:
      return 'kitchen accessories';
    case Category.cosmetics:
      return 'cosmetics';
    case Category.others:
      return 'others';
  }
}

 String getCategoryTranslations(Category category, AppLocalizations localizations){
   switch (category) {
    case Category.clothes:
      return localizations.clothes;
    case Category.shoes:
      return localizations.shoes;
    case Category.homeAccessories:
      return localizations.homeAccessories;
    case Category.electronics:
      return localizations.electronics;
    case Category.gymAccessories:
      return localizations.gymAccessories;
    case Category.cosmetics:
      return localizations.cosmetics;
    case Category.others:
      return 'others';
    case Category.kitchenAccessories:
      return localizations.kitchenAccessories;
  }
 }
