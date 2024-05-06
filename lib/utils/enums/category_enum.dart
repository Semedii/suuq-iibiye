enum Category {
  clothes,
  shoes,
  homeAccessories,
  electronics,
}

Category getCategoryFromString(String categoryString) {
  switch (categoryString.toLowerCase()) {
    case 'clothes':
      return Category.clothes;
    case 'shoes':
      return Category.shoes;
    case 'homeAccessories':
      return Category.homeAccessories;
    case 'electronics':
      return Category.electronics;
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
      return 'homeAccessories';
    case Category.electronics:
      return 'electronics';
  }
}
