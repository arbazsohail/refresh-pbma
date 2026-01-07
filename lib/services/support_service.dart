import 'package:get/get.dart';
import 'api_service.dart';
import 'api_constants.dart';

class SupportService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

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
