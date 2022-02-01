import 'dart:convert';
import 'dart:io';

import 'package:football_app/components/failure.dart';
import 'package:http/http.dart' as http;
import 'package:football_app/utils/constants.dart';

class HttpHelper {
  static const baseUrl = 'https://api.football-data.org/v2/';

  Future<dynamic> get({String? params}) async {
    Uri uri = params != null ? Uri.parse(baseUrl + params) : Uri.parse(baseUrl);
    try {
      final response = await http.get(uri, headers: {'X-Auth-Token': 'token'});
      _returnResponse(response);
    } on SocketException {
      throw Failure('No internet connection');
    } on HttpException catch (e) {
      throw Failure(e.message.split(':')[1].split(',')[0]);
    } on FormatException {
      throw Failure('Something went wrong. Please try again');
    } catch (e) {
      print('Get exception: $e');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw HttpException(response.body.toString());
      case 401:
        throw HttpException(response.body.toString());
      case 403:
        throw HttpException(response.body.toString());
      case 500:
        throw HttpException(response.body.toString());
      default:
        throw HttpException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
