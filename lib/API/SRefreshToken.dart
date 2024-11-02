import 'dart:convert';

import 'package:flutter_application_1/flutter_storage.dart';
import 'package:flutter_application_1/token.dart';
import 'package:http/http.dart' as http;

class SRefreshToken {
  static Future<Map<String, dynamic>> getAccessToken() async {
    Map<String, dynamic> result;
    try {
      String refreshToken = await Token.getRefreshToken() ?? '';
      String url =
          'http://10.0.2.2:5087/api/auth/refresh-token?token=$refreshToken';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 401) {
        result = {'status': false, 'message': 'Unauthorized'};
      }

      if (response.statusCode == 200) {
        dynamic res = json.decode(response.body);
        await FlutterStorage.storage
            .write(key: "accessToken", value: res['accessToken']);
        result = {'status': res['status']};
      } else {
        result = {'status': false, 'message': 'Check your internet connection'};
      }
    } catch (e) {
      result = {'status': false, 'message': '$e'};
    }
    return result;
  }
}
