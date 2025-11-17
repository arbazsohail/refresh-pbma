import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/terms_and_conditions_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_app_bar.dart';

class TermsAndConditionsScreen extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.darkSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'Terms & Conditions',
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
                  'Terms & Conditions',
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
                  'Welcome to the Refresh mobile application (the "App"), owned and operated by Refresh Palm Beach Medical Aesthetics, including its affiliate locations such as Refresh Port St. Lucie Medical Aesthetics and any other current or future clinics operating under the Refresh brand ("we," "our," or "us"). By using our App, you agree to the following terms and conditions ("Terms").',
                ),

                const SizedBox(height: 8),

                _buildParagraph(
                  'If you do not agree to these Terms, you must not use the App.',
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 24),

                // Section 1
                _buildSectionTitle('1. Eligibility and Acceptance of Terms'),
                _buildBulletPoint('You are at least 18 years old'),
                _buildBulletPoint('You reside in the United States'),
                _buildBulletPoint('You are using the App solely for personal, non-commercial purposes'),
                _buildBulletPoint('You agree to comply with these Terms and our Privacy Policy.'),

                const SizedBox(height: 20),

                // Section 2
                _buildSectionTitle('2. App Use and Account Termination'),
                _buildParagraph(
                  'We reserve the right, at our sole discretion, to:',
                ),
                _buildBulletPoint('Restrict, suspend, or terminate your access to the App or your account'),
                _buildBulletPoint('Revoke or adjust any privileges, points, or rewards'),
                _buildBulletPoint('Remove you from the referral or rewards system'),
                _buildBulletPoint('Deny access to any user we believe is violating our policies or using the system improperly'),
                const SizedBox(height: 12),
                _buildParagraph(
                  'This includes, but is not limited to:',
                ),
                _buildBulletPoint('Attempted fraud or abuse of the rewards system'),
                _buildBulletPoint('False or misleading information provided during registration or use'),
                _buildBulletPoint('Harassment of staff or other users'),
                _buildBulletPoint('Failure to comply with appointment, booking, or payment obligations'),

                const SizedBox(height: 20),

                // Section 3
                _buildSectionTitle('3. Referral Program'),
                _buildParagraph(
                  'To participate in the referral program, both you (the referrer) and the person you refer must:',
                ),
                _buildBulletPoint('Register and complete a qualifying service'),
                _buildBulletPoint('Use your unique link or code at the time of booking'),
                const SizedBox(height: 12),
                _buildParagraph(
                  'You may receive points as a reward. Points:',
                ),
                _buildBulletPoint('Have no cash value and cannot be exchanged for U.S. dollars or any other currency'),
                _buildBulletPoint('Are non-transferrable and non-refundable'),
                _buildBulletPoint('May not apply in conjunction with other promotions unless explicitly stated'),

                const SizedBox(height: 20),

                // Section 4
                _buildSectionTitle('4. Rewards & Redemption'),
                _buildBulletPoint('Points can only be redeemed for services available at Refresh locations'),
                _buildBulletPoint('Minimum redemption is 5,000 points (\$50 equivalent value)'),
                _buildBulletPoint('Points cannot be exchanged for cash or used outside Refresh-affiliated locations'),
                _buildBulletPoint('All redemptions are subject to review and may take up to 48 business hours to process'),
                _buildBulletPoint('Not all rewards or tiers may be available at all locations'),
                _buildBulletPoint('Points, credits, and rewards may not be combined with certain promotions at our discretion'),
                const SizedBox(height: 12),
                _buildParagraph(
                  'We reserve the right to:',
                ),
                _buildBulletPoint('Modify the point value of services at any time'),
                _buildBulletPoint('Cap or restrict the number of redemptions'),
                _buildBulletPoint('Offer time-limited or location-specific redemption options'),

                const SizedBox(height: 20),

                // Section 5
                _buildSectionTitle('5. Booking and Cancellations'),
                _buildParagraph(
                  'All bookings made through the App are:',
                ),
                _buildBulletPoint('Subject to availability'),
                _buildBulletPoint('Not guaranteed until confirmed by a Refresh team member'),
                _buildBulletPoint('Governed by our cancellation/no-show policy'),

                const SizedBox(height: 20),

                // Section 6
                _buildSectionTitle('6. User Conduct'),
                _buildParagraph(
                  'You agree not to:',
                ),
                _buildBulletPoint('Misuse or manipulate the referral or rewards system'),
                _buildBulletPoint('Upload false, illegal, or misleading information'),
                _buildBulletPoint('Impersonate another person or account'),

                const SizedBox(height: 20),

                // Section 7
                _buildSectionTitle('7. Privacy & Data Use'),
                _buildParagraph(
                  'By using the App, you consent to our collection and use of certain information, including:',
                ),
                _buildBulletPoint('Name, email, phone number, and birthdate'),
                _buildBulletPoint('Appointment and visit history'),
                _buildBulletPoint('Referral activity and user interactions'),

                const SizedBox(height: 20),

                // Section 8
                _buildSectionTitle('8. Intellectual Property'),
                _buildParagraph(
                  'All trademarks, logos, graphics, icons, design, layout, and content within the App are owned by Refresh or licensed appropriately. You may not reproduce, reuse, or redistribute any content without written consent.',
                ),

                const SizedBox(height: 20),

                // Section 9
                _buildSectionTitle('9. Limitations and Disclaimers'),
                _buildParagraph(
                  'The App and all services are provided "as-is" without warranty of any kind. We do not guarantee uninterrupted, error-free use of the App. We are not liable for:',
                ),
                _buildBulletPoint('Loss of data, points, or bookings due to technical issues'),
                _buildBulletPoint('Third-party platform outages'),
                _buildBulletPoint('Unauthorized access due to user negligence'),

                const SizedBox(height: 20),

                // Section 10
                _buildSectionTitle('10. Affiliated Locations'),
                _buildParagraph(
                  'These Terms apply to all Refresh-affiliated locations, including but not limited to:',
                ),
                _buildBulletPoint('Refresh Palm Beach Medical Aesthetics'),
                _buildBulletPoint('Refresh Port St. Lucie Medical Aesthetics'),
                _buildBulletPoint('Any current or future locations operating under the Refresh brand umbrella'),

                const SizedBox(height: 20),

                // Section 11
                _buildSectionTitle('11. Modifications & Availability'),
                _buildParagraph(
                  'We may modify or discontinue any aspect of the App at any time, including:',
                ),
                _buildBulletPoint('App features'),
                _buildBulletPoint('Point values and redemption rules'),
                _buildBulletPoint('Promotions and referral conditions'),

                const SizedBox(height: 20),

                // Section 12
                _buildSectionTitle('12. Governing Law & Disputes'),
                _buildParagraph(
                  'These Terms are governed by the laws of the State of Florida. All disputes must be filed in courts located in Palm Beach County, Florida.',
                ),

                const SizedBox(height: 32),
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
