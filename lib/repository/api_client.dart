import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'custom_Exception.dart';

class ApiClient {
  static const BASE_URL = 'https://www.cgprojects.in/lens8/api/dummy/';

  static const PACKAGES = 'packages_list';
  static const CURRENT_BOOKINGS = 'current_booking_list';

  final http.Client httpClient;

  ApiClient({required this.httpClient});

  ///GET api call
  Future<dynamic> apiCallGet(String url, {String query = ""}) async {
    var responseJson;
    var getUrl;

    if (query.isNotEmpty) {
      getUrl = '$BASE_URL$url/$query';
    } else {
      getUrl = '$BASE_URL$url';
    }

    // String deviceId = (await DeviceUtils.getDeviceDetails())[2].toString();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'device_token': deviceId ??""
    };

    // String authToken = UserData?.currentUser?.accessToken ?? "";

    // if (authToken != null && authToken != "") {
    //   headers['Accept'] = 'application/json';
    //   headers['authorization'] = "$authToken";
    // }
    headers['device_type'] = Platform.isIOS ? "ios" : "android";

    print("Api request url : $getUrl");
    print("Headers" + headers.toString());
    try {
      final response = await httpClient
          .get(
            Uri.parse(getUrl),
            headers: headers,
          )
          .timeout(const Duration(seconds: 60));
      responseJson = await _response(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> _response(http.Response response) async {
    debugPrint("Api response : ${response.body}");

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);

        return responseJson;

      case 400:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 409:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw BadRequestException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw ServerErrorException(message.toString());
      default:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        if (message != null) {
          throw ServerErrorException(message.toString());
        }
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
