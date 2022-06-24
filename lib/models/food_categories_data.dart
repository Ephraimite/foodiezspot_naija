import 'package:flutter/widgets.dart';

import 'chip_category_data.dart';

const List<String> categoryList = [
  'Native Soups',
  'Fried foods',
  'Seafoods',
  'Deserts',
  'Grills',
  'Snacks',
  'Pancake & Waffles',
];

 List<CategoryData> categoryListData = [
  CategoryData(text: 'All Categories'),
  CategoryData(image: 'assets/images/soup.png', text: 'Native Soup'),
  CategoryData(image: 'assets/images/fried_foods.png', text: 'Fried foods'),
  CategoryData(image: 'assets/images/seafoods.png', text: 'Seafoods'),
  CategoryData(image: 'assets/images/desserts.png', text: 'Deserts'),
  CategoryData(image: 'assets/images/grills.png', text: 'Grills'),
  CategoryData(image: 'assets/images/snacks.png', text: 'Snacks'),
  CategoryData(image: 'assets/images/pancake.png', text: 'Pancake & Waffles'),
];
