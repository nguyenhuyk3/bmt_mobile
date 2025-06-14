import 'package:rt_mobile/data/services/payment.dart';

class PaymentRepository {
  final PaymentService paymentService;

  PaymentRepository({required this.paymentService});

  Future<String> createPaymentURL({
    required int orderId,
    required int amount,
    required String accessToken,
  }) async {
    final response = await paymentService.createPaymentURL(
      orderId: orderId,
      amount: amount,
      accessToken: accessToken,
    );

    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is Map && rawData['payment_url'] is String) {
        return rawData['payment_url'];
      } else {
        throw Exception("invalid response format: missing payment_url");
      }
    } else {
      throw Exception(
        'failed to create payment URL (status code: ${response.statusCode})',
      );
    }
  }
}
