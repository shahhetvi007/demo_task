class PackagesList {
  String code;
  String status;
  String message;
  List<PackagesResponse> response;

  PackagesList({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  factory PackagesList.fromJson(Map<String, dynamic> json) => PackagesList(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        response: List<PackagesResponse>.from(
            json["response"].map((x) => PackagesResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class PackagesResponse {
  String title;
  String price;
  String desc;

  PackagesResponse({
    required this.title,
    required this.price,
    required this.desc,
  });

  factory PackagesResponse.fromJson(Map<String, dynamic> json) =>
      PackagesResponse(
        title: json["title"],
        price: json["price"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "desc": desc,
      };
}
