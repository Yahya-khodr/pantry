class HTTPResponse<T> {
  bool isSuccessful;
  T data;
  String message;
  int responseCode;

  HTTPResponse(
    this.isSuccessful,
    this.data,
    this.message,
    this.responseCode,
  );

  factory HTTPResponse.fromJson(Map<String, dynamic> json) {
    return HTTPResponse(
      json['isSuccessful'],
      json['data'],
      json['message'],
      json['responseCode'],
    );
  }
}
