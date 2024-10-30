import 'dart:convert';
import 'package:flutter_application_1/Model/AccountModel.dart';
import 'package:flutter_application_1/Model/LoginModel.dart';
import 'package:http/http.dart' as http;

class SAccount {
  static Future<Map<String, dynamic>> loginAccount(
      LoginModel loginModel) async {
    Map<String, dynamic> result;

    try {
      String url = 'http://10.0.2.2:5087/api/Account/login';

      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"email": loginModel.email, "password": loginModel.password}));
      dynamic res = json.decode(response.body);
      if (response.statusCode == 200) {
        result = {'status': res['status'], 'message': res['message']};
      } else {
        result = {'status': false, 'message': 'Check your internet connection'};
      }
    } catch (e) {
      result = {'status': false, 'message': '$e'};
    }
    return result;
  }

  static Future<Map<String, dynamic>> createAccount(
      AccountModel accountModel) async {
    Map<String, dynamic> result;

    try {
      String url = 'http://10.0.2.2:5087/api/Account/createaccount';
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "email": accountModel.email,
            "password": accountModel.password,
            "firstName": accountModel.firstName,
            "lastName": accountModel.lastName
          }));
      dynamic res = json.decode(response.body);
      if (response.statusCode == 200) {
        result = {'status': res['status'], 'message': res['message']};
      } else {
        result = {'status': false, 'message': 'Check your internet connection'};
      }
    } catch (e) {
      result = {'status': false, 'message': '$e'};
    }

    return result;
  }
}
