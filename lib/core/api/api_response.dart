import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  /// Creates the response from the [Api] with request's status and body.
  const ApiResponse({
    required this.statusCode,
    this.data = const {},
    this.errorMessage,
  });

  final int statusCode;
  final dynamic data;
  final String? errorMessage;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  bool get isSuccessful => statusCode == 200;

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  String toString() => toJson().toString();
}
