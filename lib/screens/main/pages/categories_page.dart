import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Categories',
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
          'Categories Page',
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
