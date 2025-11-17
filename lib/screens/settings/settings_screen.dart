import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Settings',
          showBackButton: true,
          showNotification: false,
          showSettings: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Section
              _buildSectionHeader('Account'),
              const SizedBox(height: 12),
              _buildSettingItem(
                title: 'Profile Settings',
                onTap: controller.navigateToProfileSettings,
                showArrow: true,
              ),

              _buildSettingItem(
                title: 'Change Password',
                onTap: controller.navigateToChangePassword,
                showArrow: true,
              ),

              const SizedBox(height: 24),

              // Notifications Section
              _buildSectionHeader('Notifications'),
              const SizedBox(height: 12),
              Obx(
                () => _buildSettingItem(
                  title: 'Push Notifications',
                  hasSwitch: true,
                  switchValue: controller.pushNotificationsEnabled.value,
                  onSwitchChanged: controller.togglePushNotifications,
                ),
              ),

              Obx(
                () => _buildSettingItem(
                  title: 'Email Updates',
                  hasSwitch: true,
                  switchValue: controller.emailUpdatesEnabled.value,
                  onSwitchChanged: controller.toggleEmailUpdates,
                ),
              ),

              const SizedBox(height: 24),

              // Help & Support Section
              _buildSectionHeader('Help & Support'),
              const SizedBox(height: 12),
              _buildSettingItem(
                title: 'FAQ',
                onTap: controller.navigateToFAQ,
                showArrow: true,
              ),

              _buildSettingItem(
                title: 'Contact Us',
                onTap: controller.navigateToContactUs,
                showArrow: true,
              ),

              const SizedBox(height: 24),

              // Legal & Info Section
              _buildSectionHeader('Legal & Info'),
              const SizedBox(height: 12),
              _buildSettingItem(
                title: 'Terms & Conditions',
                onTap: controller.navigateToTermsAndConditions,
                showArrow: true,
              ),

              _buildSettingItem(
                title: 'Privacy Policy',
                onTap: controller.navigateToPrivacyPolicy,
                showArrow: true,
              ),

              const SizedBox(height: 32),

              // Log Out Button
              CustomButton(
                title: 'Log Out',
                onTap: controller.logOut,
                height: 54,
                margin: 0,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                borderRadius: 12,
                titleFontSize: 16,
                horizontalPadding: 0,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.blackText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'DMSans',
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    VoidCallback? onTap,
    bool showArrow = false,
    bool hasSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    bool showTopBorder = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border:
            showTopBorder
                ? const Border(
                  top: BorderSide(color: Color(0xFFEBF0F6), width: 1),
                )
                : null,
      ),
      child: InkWell(
        onTap: hasSwitch ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.blackText,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSans',
                ),
              ),
              if (showArrow)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9E9E9E),
                  size: 24,
                ),
              if (hasSwitch)
                Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: AppColors.secondary,
                  activeTrackColor: AppColors.secondary.withValues(alpha: 0.3),
                  inactiveThumbColor: const Color(0xFFBDBDBD),
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
