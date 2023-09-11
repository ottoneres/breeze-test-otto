import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final int statusCode;
  final dynamic data;
  final String? errorMessage;

  /// Creates the response from the [Api] with request's status and body.
  const ApiResponse({required this.statusCode, this.data = const {}, this.errorMessage});

  bool get isSuccessful => statusCode == 200;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  String toString() => toJson().toString();
}
