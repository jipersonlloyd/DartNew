import 'dart:convert';
import 'package:http/http.dart' as http;

class SLogin {
  static Future<Map<String, dynamic>> loginAccount(
      String email, String password) async {
    Map<String, dynamic> result;

    try {
      String url = 'http://10.0.2.2:5087/api/Account/login';

      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": email, "password": password}));
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
