import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF15243F);
const ksecondryColor = Color(0xFF3a4d6F);
const kLightBlue = Color(0xFF99a8c2);
const kExtraLite = Color(0xFFcfd9e9);
const kBlack = Color(0xFF000000);
const kWhite = Color(0xFFffffff);
const kGray = Color(0xFFc4cbd9);
const kOrange = Color(0xFFf04a4a);
//http://10.0.2.2
//192.168.100.6
const kBaseUrl = "https://ta7t-bety.vercel.app/api/v1/";
const kBaseCategoryAssets = "assets/images/market_categories/";

const kAddressBox = "addressBox";
const kCurUserBox = "curUserBox";
const kRecentSearchBox = "RecentSearchBox";
const kBasketBox = "basketBox";
const kProvidersBox = "providerBox";

Map<String, IconData> categoryIcons = {
  "R-Electric": Icons.electrical_services,
  "R-Painters": Icons.format_paint,
  "R-Carpenters": Icons.handyman,
  "R-Alometetal": Icons.construction,
  "R-Air conditioning technician": Icons.ac_unit,
  "R-Plumber": Icons.plumbing,
  "HW-Standerd": Icons.cleaning_services,
  "HW-Deep": Icons.layers,
  "HW-Cleaning": Icons.clean_hands,
  "HW-HouseKeeper": Icons.home,
  "HW-Car wash": Icons.local_car_wash,
  "HW-Dry cleaning": Icons.local_laundry_service,
  "F-Restaurants": Icons.restaurant,
  "M-Supermarket": Icons.shopping_cart,
  "M-miqla": Icons.local_dining,
  "HC-Pharmacies": Icons.local_pharmacy,
  "HC-Clinics": Icons.local_hospital,
};
