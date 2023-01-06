import 'dart:convert';
import 'dart:io';

import 'package:feathercap_demo/main.dart';
import 'package:feathercap_demo/model/services/base_services.dart';
import 'package:feathercap_demo/model/services/urls.dart';
import 'package:http/http.dart' as http;

import '../apis/app_exceptions.dart';

class TvShowServices extends BaseServices {

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final mainUrl = Uri.parse(baseUrl + url);
      final response = await http.get(mainUrl);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

}