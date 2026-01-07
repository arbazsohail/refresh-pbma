import 'package:get/get.dart';
import 'api_service.dart';
import 'api_constants.dart';

class WalletService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Submit redeem points request
  ///
  /// Endpoint: POST /api/user/redeem-request
  /// Body: { "points": 500 }
  Future<Map<String, dynamic>> submitRedeemRequest({
    required int points,
  }) async {
    try {
      final requestBody = {
        'points': points,
      };

      print('📤 Submitting redeem request for $points points');
      print('Request Body: $requestBody');

      final response = await _apiService.post(
        ApiConstants.redeemRequest,
        data: requestBody,
      );

      print('📥 Redeem Request Response: ${response.data}');

      if (response.data['code'] == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Failed to submit redeem request';
      }
    } catch (e) {
      print('❌ Redeem Request Error: $e');
      rethrow;
    }
  }
}
