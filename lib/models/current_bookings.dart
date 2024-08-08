class CurrentBookings {
  String code;
  String status;
  String message;
  List<BookingsResponse> response;

  CurrentBookings({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  factory CurrentBookings.fromJson(Map<String, dynamic> json) =>
      CurrentBookings(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        response: List<BookingsResponse>.from(
            json["response"].map((x) => BookingsResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class BookingsResponse {
  String title;
  String fromDate;
  String fromTime;
  String toDate;
  String toTime;

  BookingsResponse({
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
  });

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      BookingsResponse(
        title: json["title"],
        fromDate: json["from_date"],
        fromTime: json["from_time"],
        toDate: json["to_date"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "from_date": fromDate,
        "from_time": fromTime,
        "to_date": toDate,
        "to_time": toTime,
      };
}
