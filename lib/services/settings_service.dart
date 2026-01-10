import 'package:get/get.dart';
import 'api_service.dart';
import 'api_constants.dart';

/// Service for settings-related API calls
/// Handles FAQs, support queries, and other settings features
class SettingsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get FAQs from server
  ///
  /// Endpoint: GET /api/user/faq
  /// Returns: Response data from server with list of FAQs
  /// Throws: String error message on failure
  Future<Map<String, dynamic>> getFaqs() async {
    try {
      print('📤 Get FAQs Request');

      final response = await _apiService.get(ApiConstants.getFaqs);

      print('📥 Get FAQs Response: ${response.data}');

      // API Response format:
      // {
      //   "code": 200,
      //   "message": "Retrieved data successfully!.",
      //   "data": [
      //     {
      //       "id": 1,
      //       "title": "Question 01",
      //       "content": "lorem ipsum",
      //       "createdAt": "2025-11-25T09:56:47.000Z",
      //       "updatedAt": "2025-11-25T09:56:47.000Z"
      //     }
      //   ]
      // }

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to fetch FAQs';
      }
    } catch (e) {
      print('❌ Get FAQs Error: $e');
      rethrow;
    }
  }

  /// Submit support/contact query
  ///
  /// Endpoint: POST /api/user/support-query
  /// Body: { "name": "...", "email": "...", "message": "..." }
  Future<Map<String, dynamic>> submitSupportQuery({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final requestBody = {
        'name': name,
        'email': email,
        'message': message,
      };

      print('📤 Submitting support query');
      print('Request Body: $requestBody');

      final response = await _apiService.post(
        ApiConstants.supportQuery,
        data: requestBody,
      );

      print('📥 Support Query Response: ${response.data}');

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to submit support query';
      }
    } catch (e) {
      print('❌ Support Query Error: $e');
      rethrow;
    }
  }
}
