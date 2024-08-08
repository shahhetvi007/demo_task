import 'package:demo_task/models/current_bookings.dart';
import 'package:demo_task/models/packages.dart';
import 'package:http/http.dart' as http;

import 'api_client.dart';

class Repository {
  final ApiClient apiClient;

  Repository({required this.apiClient});

  static Repository getInstance() {
    return Repository(apiClient: ApiClient(httpClient: http.Client()));
  }

  Future<PackagesList> getPackagesList() async {
    try {
      dynamic response = await apiClient.apiCallGet(ApiClient.PACKAGES);
      return PackagesList.fromJson(response);
    } catch (e) {
      print("error$e");
      throw e;
    }
  }

  Future<CurrentBookings> getCurrentBookings() async {
    try {
      dynamic response = await apiClient.apiCallGet(ApiClient.CURRENT_BOOKINGS);
      return CurrentBookings.fromJson(response);
    } catch (e) {
      print("error$e");
      throw e;
    }
  }
}
