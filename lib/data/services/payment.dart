import 'package:dio/dio.dart';

import 'package:rt_mobile/data/models/api_response.dart';

class PaymentService {
  final Dio dio;

  PaymentService({required this.dio});

  Future<APIReponse> createPaymentURL({
    required int orderId,
    required int amount,
    required String accessToken,
  }) async {
    // final accessToken = await storage.read(ACCESS_TOKEN);

    // if (accessToken == null) {
    //   return APIReponse(statusCode: NO_ACCESS_TOKEN);
    // }

    final response = await dio.post(
      '/payment_service/momo/customer/create_payment_url',
      data: {'order_id': orderId, 'amount': amount},
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
