class APIReponse {
  final int? statusCode;
  final String message;
  final Map<String, dynamic> data;

  const APIReponse({
    required this.statusCode,
    this.message = "",
    this.data = const {},
  });

  factory APIReponse.fromJson(Map<String, dynamic> json) {
    return APIReponse(
      statusCode: json['status_code'],
      message: json['message'] ?? "",
      data: json['data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {'status_code': statusCode, 'message': message, 'data': data};
  }
}
