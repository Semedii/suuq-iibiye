enum Category {
  clothes,
  shoes,
  homeAccessories,
  electronics,
  gymAccessories,
  kitchenAccessories,
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
    default:
      throw Exception('Unknown category: $categoryString');
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
  }
}
