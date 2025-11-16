import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Explore',
        showNotification: true,
        showSettings: true,
        onNotificationTap: () {
          // TODO: Handle notification tap
        },
        onSettingsTap: () {
          // TODO: Handle settings tap
        },
      ),
      body: const Center(
        child: Text(
          'Explore Page',
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
