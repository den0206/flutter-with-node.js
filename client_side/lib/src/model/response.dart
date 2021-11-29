import 'dart:convert';

class ResponseAPI {
  bool status;
  String message;
  String? error;
  dynamic data;

  ResponseAPI({
    required this.status,
    required this.message,
    this.error,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data,
    };
  }

  factory ResponseAPI.fromMap(Map<String, dynamic> map) {
    return ResponseAPI(
      status: map['status'],
      message: map['message'],
      error: map['error'] != null ? map['error'] : null,
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseAPI.fromJson(String source) =>
      ResponseAPI.fromMap(json.decode(source));
}
