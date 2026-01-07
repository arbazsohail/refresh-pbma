import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'api_service.dart';
import 'api_constants.dart';

/// Payment Service
/// Handles all payment and consent-related API calls
class PaymentService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();


  Future<Map<String, dynamic>> submitConsentQuestionnaire({
    required List<Map<String, String>> questionnaireDetails,
  }) async {
    try {
      final requestBody = {
        'questionnaire_details': questionnaireDetails,
      };

      print('📤 Submitting consent questionnaire (${questionnaireDetails.length} questions)');
      print('Request Body: $requestBody');

      final response = await _apiService.post(
        ApiConstants.consentSubmission,
        data: requestBody,
      );

      print('📥 Consent Submission Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Consent submitted successfully",
      //   "data": {}
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to submit consent';
      }
    } catch (e) {
      print('❌ Consent Submission Error: $e');
      rethrow;
    }
  }
}
