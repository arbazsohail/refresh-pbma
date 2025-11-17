import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/privacy_policy_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Privacy Policy',
          showBackButton: true,
          showNotification: false,
          showSettings: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Title
                const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.blackText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSans',
                  ),
                ),

                const SizedBox(height: 16),

                // Introduction
                _buildParagraph(
                  'Refresh Palm Beach Medical Aesthetics and its affiliated locations ("Refresh," "we," "our," or "us") respect your privacy. This Privacy Policy explains how we collect, use, store, and protect your personal information when you use the Refresh mobile application (the "App").',
                ),

                const SizedBox(height: 8),

                _buildParagraph(
                  'By using our App, you consent to the practices described in this Privacy Policy. If you do not agree with this policy, please do not use the App.',
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 24),

                // Section 1
                _buildSectionTitle('1. Information We Collect'),
                _buildParagraph(
                  'We may collect the following types of information:',
                ),
                const SizedBox(height: 8),
                _buildSubsectionTitle('Personal Information:'),
                _buildBulletPoint('Full name'),
                _buildBulletPoint('Email address'),
                _buildBulletPoint('Phone number'),
                _buildBulletPoint('Date of birth'),
                _buildBulletPoint('Profile photo (if provided)'),
                const SizedBox(height: 12),
                _buildSubsectionTitle('Account & Activity Data:'),
                _buildBulletPoint('Account registration details'),
                _buildBulletPoint('Appointment history and bookings'),
                _buildBulletPoint('Services purchased or redeemed'),
                _buildBulletPoint('Referral activity and links used'),
                _buildBulletPoint('Points earned, redeemed, and tier status'),
                const SizedBox(height: 12),
                _buildSubsectionTitle('Technical & Usage Data:'),
                _buildBulletPoint('Device type, operating system, and unique identifiers'),
                _buildBulletPoint('IP address and general location information'),
                _buildBulletPoint('App usage patterns, screens viewed, and interactions'),
                _buildBulletPoint('Push notification preferences'),

                const SizedBox(height: 20),

                // Section 2
                _buildSectionTitle('2. How We Use Your Information'),
                _buildParagraph(
                  'We use the information we collect to:',
                ),
                _buildBulletPoint('Create and manage your account'),
                _buildBulletPoint('Process bookings, appointments, and payments'),
                _buildBulletPoint('Administer the referral and rewards program'),
                _buildBulletPoint('Send appointment reminders and service updates'),
                _buildBulletPoint('Provide customer support'),
                _buildBulletPoint('Improve app functionality and user experience'),
                _buildBulletPoint('Send promotional offers and marketing communications (with your consent)'),
                _buildBulletPoint('Comply with legal obligations'),
                _buildBulletPoint('Detect and prevent fraud or misuse of the App'),

                const SizedBox(height: 20),

                // Section 3
                _buildSectionTitle('3. How We Share Your Information'),
                _buildParagraph(
                  'We do not sell your personal information. We may share your data with:',
                ),
                const SizedBox(height: 8),
                _buildSubsectionTitle('Service Providers:'),
                _buildBulletPoint('Third-party vendors who help us operate the App (e.g., payment processors, cloud hosting, analytics)'),
                const SizedBox(height: 12),
                _buildSubsectionTitle('Affiliated Locations:'),
                _buildBulletPoint('Refresh-branded clinics for appointment coordination and service delivery'),
                const SizedBox(height: 12),
                _buildSubsectionTitle('Legal Compliance:'),
                _buildBulletPoint('Authorities when required by law, court order, or to protect our legal rights'),
                const SizedBox(height: 12),
                _buildSubsectionTitle('Business Transfers:'),
                _buildBulletPoint('In the event of a merger, acquisition, or sale of assets, your information may be transferred'),

                const SizedBox(height: 20),

                // Section 4
                _buildSectionTitle('4. Data Retention'),
                _buildParagraph(
                  'We retain your personal information for as long as your account is active or as needed to provide services. After account deletion, we may retain certain data for legal, regulatory, or business purposes (e.g., transaction records, fraud prevention).',
                ),

                const SizedBox(height: 20),

                // Section 5
                _buildSectionTitle('5. Data Security'),
                _buildParagraph(
                  'We use industry-standard security measures to protect your information, including encryption, secure servers, and access controls. However, no system is 100% secure, and we cannot guarantee absolute security.',
                ),

                const SizedBox(height: 20),

                // Section 6
                _buildSectionTitle('6. Your Privacy Rights'),
                _buildParagraph(
                  'Depending on your location, you may have the following rights:',
                ),
                _buildBulletPoint('Access: Request a copy of the personal data we hold about you'),
                _buildBulletPoint('Correction: Update or correct inaccurate information'),
                _buildBulletPoint('Deletion: Request deletion of your account and personal data (subject to legal retention requirements)'),
                _buildBulletPoint('Opt-Out: Unsubscribe from marketing emails or disable push notifications'),
                _buildBulletPoint('Data Portability: Request your data in a portable format (where applicable)'),
                const SizedBox(height: 12),
                _buildParagraph(
                  'To exercise these rights, contact us at the information provided in Section 10.',
                ),

                const SizedBox(height: 20),

                // Section 7
                _buildSectionTitle('7. Cookies and Tracking Technologies'),
                _buildParagraph(
                  'The App may use cookies, local storage, and similar technologies to:',
                ),
                _buildBulletPoint('Remember your preferences and login status'),
                _buildBulletPoint('Analyze app usage and performance'),
                _buildBulletPoint('Deliver personalized content and offers'),
                const SizedBox(height: 12),
                _buildParagraph(
                  'You can manage cookie preferences through your device settings, though this may affect app functionality.',
                ),

                const SizedBox(height: 20),

                // Section 8
                _buildSectionTitle('8. Third-Party Links'),
                _buildParagraph(
                  'The App may contain links to third-party websites or services. We are not responsible for the privacy practices of those third parties. Please review their privacy policies before providing any information.',
                ),

                const SizedBox(height: 20),

                // Section 9
                _buildSectionTitle('9. Children\'s Privacy'),
                _buildParagraph(
                  'The App is intended for users aged 18 and older. We do not knowingly collect personal information from individuals under 18. If we become aware of such data collection, we will delete it promptly.',
                ),

                const SizedBox(height: 20),

                // Section 10
                _buildSectionTitle('10. Changes to This Privacy Policy'),
                _buildParagraph(
                  'We may update this Privacy Policy from time to time. Any changes will be posted within the App, and the "Last Updated" date will be revised. Continued use of the App after changes constitutes acceptance of the updated policy.',
                ),

                const SizedBox(height: 20),

                // Section 11
                _buildSectionTitle('11. Contact Us'),
                _buildParagraph(
                  'If you have questions or concerns about this Privacy Policy or how we handle your data, please contact us:',
                ),
                const SizedBox(height: 8),
                _buildBulletPoint('Refresh Palm Beach Medical Aesthetics'),
                _buildBulletPoint('Phone: 561-250-6169'),
                _buildBulletPoint('Email: info@refreshpalmbeach.com'),

                const SizedBox(height: 32),

                // Last Updated
                _buildParagraph(
                  'Last Updated: ${DateTime.now().year}',
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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

  Widget _buildSubsectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.blackText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'DMSans',
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, {FontWeight fontWeight = FontWeight.w400}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.greyText,
          fontSize: 14,
          fontWeight: fontWeight,
          fontFamily: 'DMSans',
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Icon(
              Icons.circle,
              size: 6,
              color: AppColors.greyText,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.greyText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSans',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
