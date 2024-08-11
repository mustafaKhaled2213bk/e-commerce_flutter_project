// import 'package:shopsmart_users_ar/models/categories_model.dart';


import 'package:e_commerce/models/categories_model.dart';

import '../services/assets_manager.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "smartphones",
      image: AssetsManager.mobiles,
      name: "Phones",
    ),
    CategoryModel(
      id: "laptops",
      image: AssetsManager.pc,
      name: "Laptops",
    ),
    CategoryModel(
      id: "mens-watches",
      image: AssetsManager.watch,
      name: "Watches",
    ),
    CategoryModel(
      id: "womens-dresses",
      image: AssetsManager.fashion,
      name: "Clothes",
    ),
    CategoryModel(
      id: "mens-shoes",
      image: AssetsManager.shoes,
      name: "Shoes",
    ),
    CategoryModel(
      id: "fragrances",
      image: AssetsManager.cosmetics,
      name: "Fragrances",
    ),
    CategoryModel(
      id: "motorcycle",
      image: AssetsManager.motocycle,
      name: "Motocycles",
    ),
    CategoryModel(
      id: 'beauty',
      image: AssetsManager.beauty,
      name: 'Beauty',
    )
  ];
}
