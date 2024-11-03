import 'dart:convert';

import 'package:flutter_application_1/Model/WeatherModel.dart';
import 'package:flutter_application_1/token.dart';
import 'package:http/http.dart' as http;

class STest {
  static Future<Map<String, dynamic>> getWeatherData() async {
    Map<String, dynamic> result;
    List<WeatherModel> weatherList = [];
    try {
      String url = 'http://10.0.2.2:5087/api/weather';
      String token = await Token.getAccessToken() ?? '';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 401) {
        result = {'status': false, 'message': 'Unauthorized'};
        return result;
      }

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);

        for (int i = 0; i < res.length; i++) {
          WeatherModel weatherModel = WeatherModel(
            date: res[i]['date'],
            temperatureC: res[i]['temperatureC'],
            temperatureF: res[i]['temperatureF'],
            summary: res[i]['summary'],
          );
          weatherList.add(weatherModel);
        }
        result = {'status': true, 'message': weatherList};
      } else {
        result = {'status': false, 'message': 'Check your internet connection'};
      }
    } catch (e) {
      result = {'status': false, 'message': '$e'};
    }
    return result;
  }
}
