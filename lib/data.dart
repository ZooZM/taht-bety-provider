import 'package:flutter/material.dart';
import 'package:taht_bety_provider/auth/data/models/category_model.dart';

class Data {
  Data();
  static List<CategoryModel> categores = [
    CategoryModel(
        name: "R-Electric", hasCliced: false, icon: Icons.electrical_services),
    CategoryModel(
        name: "R-Painters", hasCliced: false, icon: Icons.format_paint),
    CategoryModel(name: "R-Carpenters", hasCliced: false, icon: Icons.handyman),
    CategoryModel(
        name: "R-Alometetal", hasCliced: false, icon: Icons.construction),
    CategoryModel(
        name: "R-Air conditioning technician",
        hasCliced: false,
        icon: Icons.ac_unit),
    CategoryModel(name: "R-Plumber", hasCliced: false, icon: Icons.plumbing),
    CategoryModel(
        name: "HW-Standerd", hasCliced: false, icon: Icons.cleaning_services),
    CategoryModel(name: "HW-Deep", hasCliced: false, icon: Icons.layers),
    CategoryModel(
        name: "HW-Cleaning", hasCliced: false, icon: Icons.clean_hands),
    CategoryModel(name: "HW-HouseKeeper", hasCliced: false, icon: Icons.home),
    CategoryModel(
        name: "HW-Car wash", hasCliced: false, icon: Icons.local_car_wash),
    CategoryModel(
        name: "HW-Dry cleaning",
        hasCliced: false,
        icon: Icons.local_laundry_service),
    CategoryModel(
        name: "F-Restaurants", hasCliced: false, icon: Icons.restaurant),
    CategoryModel(
        name: "M-Supermarket", hasCliced: false, icon: Icons.shopping_cart),
    CategoryModel(name: "M-miqla", hasCliced: false, icon: Icons.local_dining),
    CategoryModel(
        name: "HC-Pharmacies", hasCliced: false, icon: Icons.local_pharmacy),
    CategoryModel(
        name: "HC-Clinics", hasCliced: false, icon: Icons.local_hospital),
  ];
  static List<String> categoresNames = [
    "R-Electric",
    "R-Painters",
    "R-Carpenters",
    "R-Alometetal",
    "R-Air conditioning technician",
    "R-Plumber",
    "HW-Standerd",
    "HW-Deep",
    "HW-Cleaning",
    "HW-HouseKeeper",
    "HW-Car wash",
    "HW-Dry cleaning",
    "F-Restaurants",
    "M-Supermarket",
    "M-miqla",
    "HC-Pharmacies",
    "HC-Clinics"
  ];
}
