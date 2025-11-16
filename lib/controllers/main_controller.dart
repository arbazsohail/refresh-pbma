import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/main/pages/home_page.dart';
import '../screens/main/pages/categories_page.dart';
import '../screens/main/pages/favorites_page.dart';
import '../screens/main/pages/profile_page.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  // List of pages for bottom navigation
  final List<Widget> pages = [
    const HomePage(),
    const CategoriesPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  // Change page
  void changePage(int index) {
    currentIndex.value = index;
  }
}
