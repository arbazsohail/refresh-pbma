import 'package:flutter/material.dart';
import 'package:refresh_pbma/widgets/custom_app_bar.dart';
import '../../utils/app_colors.dart';

class RewardsTermsScreen extends StatelessWidget {
  const RewardsTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: '',
        showBackButton: true,
        showNotification: false,
        showSettings: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Refresh Loyalty Points Program Terms of Use',
              style: TextStyle(
                color: Color(0xFF141413),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Last Updated: 2025',
              style: TextStyle(
                color: Color(0xFF888F9A),
                fontSize: 14,
                fontFamily: 'DMSans',
              ),
            ),
            const SizedBox(height: 20),
            _buildParagraph(
              'These Terms of Use (Terms) constitute a legally binding agreement governing all aspects of participation in the Refresh Loyalty Points Program (Program), which is offered, administered, controlled, and enforced by Refresh Palm Beach Medical Aesthetics, Refresh Port St. Lucie Medical Aesthetics, Refresh Vero Beach Medical Aesthetics, and any current or future affiliated or related entities, locations, brands, trade names, assumed names, professional entities, management entities, holding companies, successor entities, subsidiaries, programs, memberships, services, platforms, systems, technologies, applications, or business lines, whether now existing or hereafter formed (collectively, Refresh, we, us, or our). By utilizing the mobile app on any interface you agree to all terms set forth.',
            ),
            _buildParagraph(
              'The Program is a voluntary, discretionary, promotional loyalty initiative established solely for marketing, engagement, and customer appreciation purposes. The Program is not a contract for medical, aesthetic, wellness, or any other services; is not a medical treatment plan; is not a plan of care; is not health insurance; is not a warranty; is not a guarantee of pricing, discounts, availability, outcomes, access, scheduling, candidacy, or results; and does not create, confer, or imply any vested, accrued, proprietary, contractual, fiduciary, or equitable rights of any kind. Participation in the Program does not alter, supplement, replace, or amend any separate consent forms, treatment agreements, financial agreements, membership agreements, financing agreements, office policies, or provider determinations.',
            ),
            _buildParagraph(
              'Points, tiers, rewards, benefits, discounts, and any related offerings exist solely at the pleasure of Refresh as revocable promotional instruments. They have no monetary value, do not constitute currency or property, do not represent consideration for services rendered, and may be modified, restricted, suspended, revoked, reduced, revalued, reinterpreted, or eliminated at any time in Refresh\'s sole and absolute discretion, with or without notice, and without liability or obligation of compensation.',
            ),
            _buildParagraph(
              'By enrolling in, accessing, registering for, earning, holding, accruing, viewing, attempting to view, redeeming, attempting to redeem, referencing, relying upon, or otherwise using or participating in the Program in any manner whatsoever, you affirmatively acknowledge, represent, and agree that: you have read these Terms in their entirety; you fully understand them; you have had the opportunity to seek independent legal advice if desired; you voluntarily accept and agree to be bound by these Terms; and you agree that these Terms govern all present and future participation in the Program, including all amendments, modifications, restatements, supplements, replacements, and successor versions, whether or not you receive direct notice of such changes.',
            ),
            _buildSection(
              '1. Absolute Program Authority and Reservation of Rights',
              'Refresh retains sole, exclusive, absolute, and continuing authority over the Program. Participation is permitted only at Refresh\'s discretion.\n\nRefresh may, at any time and for any reason, with or without notice, and without liability:\n\n• Modify, suspend, discontinue, replace, reinterpret, restrict, or terminate the Program in whole or in part\n• Add, remove, rename, or restructure tiers, point thresholds, rewards, benefits, discounts, or eligibility criteria\n• Change point earning rates, redemption values, required point deductions, expiration rules, or usage limits\n• Limit availability by location, provider, service line, equipment, inventory, staff, or regulatory constraints\n• Correct errors, including but not limited to pricing, point balances, tier placement, or reward eligibility\n\nNo oral statements, marketing materials, advertisements, staff representations, screenshots, emails, or prior versions of the Program create enforceable rights.',
            ),
            _buildSection(
              '2. Eligibility, Enrollment, and Account Status',
              'Eligibility is determined exclusively by Refresh. Enrollment may be automatic, invitation only, promotional, conditional, limited time, or revoked at any time.\n\nRefresh may deny, suspend, freeze, downgrade, restrict, or terminate any account or participant for any reason we feel necessary, including but not limited to:\n\n• Suspected abuse, misuse, manipulation, or circumvention\n• Chargebacks, refunds, payment disputes, or financing reversals\n• Violation of office policies, conduct standards, or safety protocols\n• Harassment, intimidation, coercion, or inappropriate conduct toward staff or providers\n• Regulatory, compliance, licensing, or medical concerns\n• Operational necessity or business judgment\n\nTermination results in immediate forfeiture of all points, rewards, tiers, and benefits without compensation.',
            ),
            _buildSection(
              '3. Points Characteristics and Legal Nature',
              'Points:\n\n• Have no cash value\n• Are not currency, property, or compensation\n• Are non refundable, non transferable, non assignable, non inheritable\n• May not be sold, bartered, gifted, pledged, exchanged, or combined\n• Exist solely as a revocable promotional measure\n\nPoints do not constitute consideration for medical services and do not alter standard pricing, consent, or billing obligations.',
            ),
            _buildSection(
              '4. Points Accrual Rules',
              'Points are earned only through qualifying activities expressly designated by Refresh. Qualifying criteria may vary by:\n\n• Location\n• Provider\n• Service category\n• Device or product\n• Payment method\n• Promotional campaign\n• Time period\n\nThe following do not earn points unless expressly stated:\n\n• Complimentary services or products\n• Refunded or reversed transactions\n• Chargebacks or disputes\n• Financed or third party paid services\n• Insurance billed services\n• Promotional giveaways\n\nRefresh may retroactively adjust or remove points at its discretion.',
            ),
            _buildSection(
              '5. Tier Structure and Advancement Logic',
              'Tier placement is determined solely by qualifying point totals as calculated by Refresh systems. Tier thresholds are subject to change.\n\nTier status:\n\n• Is not permanent\n• May be adjusted, downgraded, frozen, or reset\n• May be affected by inactivity, refunds, disputes, or compliance issues\n\nIf a reward is earned but not redeemed within a tier and the participant advances to a higher tier, the unused reward may carry forward. Once a reward is redeemed within a tier, it does not duplicate, roll forward, or regenerate in future tiers.',
            ),
            _buildSection(
              '6. Rewards, Benefits, and Redemption Conditions',
              'All rewards are promotional, optional, limited, and subject to:\n\n• Availability\n• Medical eligibility\n• Provider discretion\n• Regulatory compliance\n• Clinical appropriateness\n• Equipment availability\n• Inventory limitations\n\nRewards:\n\n• Cannot be redeemed for cash or credit\n• Cannot be substituted or exchanged\n• Cannot be combined with other promotions unless expressly allowed\n• May require consultations, point deductions, or scheduling limitations\n• May be revoked or modified prior to redemption',
            ),
            _buildSection(
              '7. Tier Descriptions and Reward Examples',
              'The following tier descriptions are illustrative and non binding. Point costs and benefits may change at any time.\n\nRefresh Tier: 0–2,499 points\nGlow Tier: 2,500–4,999 points\nRadiance Tier: 5,000–9,999 points\nLuminary Tier: 10,000–12,499 points\nElite Tier: 12,500–14,999 points\nIcon Tier: 15,000–19,999 points\nPlatinum Tier: 20,000–24,999 points\nDiamond Tier: 25,000–39,999 points\nRefresh X Tier: 39,999+ points\n\nSpecific rewards, discounts, free trials, point deductions, or complimentary services associated with any tier are subject to Section 1 and may be changed, revoked, or limited at any time.\n\nRefresh X is invitation based, private, non transferable, and revocable at any time. Access may be withdrawn for misuse, abuse, or business judgment.',
            ),
            _buildSection(
              '8. Medical and Clinical Authority Override',
              'All medical, aesthetic, and wellness services are governed by clinical judgment. Loyalty participation does not override medical discretion.\n\nRefresh may refuse, modify, delay, substitute, or discontinue any service or reward based on safety, appropriateness, or compliance considerations.',
            ),
            _buildSection(
              '9. Expiration, Inactivity, and Forfeiture',
              'Points, rewards, and tiers may expire due to:\n\n• Inactivity\n• Program changes\n• Regulatory requirements\n• Account termination\n\nExpired or forfeited points have no value and will not be reinstated.',
            ),
            _buildSection(
              '10. Error Correction and Clawback Rights',
              'Refresh reserves the right to correct errors including but not limited to:\n\n• Incorrect point postings\n• Tier miscalculations\n• Improper redemptions\n• Staff mistakes\n\nImproperly issued rewards may be voided, reversed, or reclaimed.',
            ),
            _buildSection(
              '11. No Guarantees or Reliance',
              'The Program is provided as is and as available. Refresh disclaims all warranties, express or implied.\n\nParticipants agree they have not relied on representations outside these Terms.',
            ),
            _buildSection(
              '12. Limitation of Liability',
              'To the maximum extent permitted by law, Refresh shall not be liable for any damages arising from participation, inability to participate, or program changes.',
            ),
            _buildSection(
              '13. Arbitration, Class Action Waiver, and Venue',
              'Any dispute shall be resolved by binding arbitration under Florida law. Participants waive the right to participate in class actions.\n\nVenue for any permitted court action shall lie exclusively in Florida.',
            ),
            _buildSection(
              '14. Governing Law and Severability',
              'These Terms are governed by the laws of the State of Florida. If any provision is unenforceable, the remaining provisions remain in effect.',
            ),
            _buildSection(
              '15. Acceptance and Amendments',
              'Continued participation constitutes acceptance of all current and future revisions to these Terms.\n\nRefresh may update, amend, restate, supplement, or replace these Terms at any time. Updated Terms will apply immediately upon posting, publication, internal system update, or implementation, regardless of whether a participant has reviewed them.\n\nParticipants waive any right to receive individual notice of changes.',
            ),
            _buildSection(
              '16. Pricing Independence and Separation From Medical Fees',
              'Participation in the Program does not alter, cap, lock, or guarantee pricing for any medical, aesthetic, or wellness service.\n\nStandard pricing, membership pricing, promotional pricing, and financing terms are determined independently of the Program and may change at any time.\n\nPoints and rewards do not offset required deposits, consultation fees, cancellation fees, no show fees, retail pricing, device minimums, or provider fees unless expressly stated in writing by Refresh.',
            ),
            _buildSection(
              '17. No Insurance, No Medical Necessity, No Entitlement',
              'The Program is not health insurance, is not a substitute for insurance, and does not provide coverage, reimbursement, or entitlement to care.\n\nAll rewards and discounts are promotional only and are not medically necessary services.\n\nNo reward constitutes a guarantee of candidacy, outcome, timing, or availability of any treatment.',
            ),
            _buildSection(
              '18. Compliance, Regulatory, and Licensing Supremacy',
              'The Program is subordinate to all applicable federal, state, and local laws, rules, regulations, licensing requirements, and professional standards.\n\nIf any aspect of the Program conflicts with:\n\n• Medical board guidance\n• Department of Health requirements\n• Licensing restrictions\n• Scope of practice limitations\n• Corporate practice of medicine doctrines\n• Payor or financing regulations\n\nRefresh may immediately modify or discontinue affected rewards or tiers without liability.',
            ),
            _buildSection(
              '19. Memberships, Financing, and Third Party Relationships',
              'Loyalty participation does not guarantee eligibility for memberships, subscription programs, financing, or third party payment plans.\n\nThird party terms govern all financing, memberships, or subscriptions. Refresh is not responsible for third party denials, cancellations, or disputes.\n\nPoints may not be applied toward outstanding balances, delinquent accounts, or contractual payment obligations.',
            ),
            _buildSection(
              '20. Non Transferability Between Locations and Accounts',
              'Although Refresh operates multiple locations, points and rewards may be restricted by location, equipment, staffing, or operational considerations.\n\nRefresh may restrict cross location redemptions or require redemption only at the originating location.\n\nAccounts may not be merged or transferred without express written approval.',
            ),
            _buildSection(
              '21. Conduct, Safety, and Professional Environment',
              'Participation requires adherence to all office policies, codes of conduct, and safety standards.\n\nAbusive, threatening, disruptive, coercive, or inappropriate behavior toward staff, providers, or other clients may result in immediate termination from the Program.\n\nTermination under this section results in forfeiture without refund or compensation.',
            ),
            _buildSection(
              '22. Suspension During Investigations',
              'Refresh may temporarily suspend accounts, points, or redemptions during investigations of suspected abuse, disputes, chargebacks, or compliance issues.\n\nSuspension does not entitle participants to extensions, reinstatements, or compensation.',
            ),
            _buildSection(
              '23. Data, Systems, and Technical Limitations',
              'Program tracking relies on electronic systems which may experience errors, delays, outages, or inaccuracies.\n\nRefresh is not responsible for system failures, software errors, data loss, or delayed postings.\n\nRefresh may rely on internal records as conclusive.',
            ),
            _buildSection(
              '24. Indemnification',
              'Participants agree to indemnify, defend, and hold harmless all entities under the Refresh umbrella that share common ownership (Refresh Palm Beach Medical Aesthetics, Refresh Port St. Lucie Medical Aesthetics, Refresh Vero Beach Medical Aesthetics, and any current or future affiliated or related entities), its owners, physicians, providers, staff, affiliates, and agents from any claim arising from participation in the Program.',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4E555B),
          fontSize: 15,
          fontFamily: 'DMSans',
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF141413),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'DMSans',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF4E555B),
              fontSize: 14,
              fontFamily: 'DMSans',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
