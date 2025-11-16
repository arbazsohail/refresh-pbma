import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: AppColors.blackText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'DMSans',
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Favorites Page',
          style: TextStyle(
            color: AppColors.blackText,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'DMSans',
          ),
        ),
      ),
    );
  }
}
