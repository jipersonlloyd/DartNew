import 'package:flutter_application_1/flutter_storage.dart';

class Token {
  static Future<String?> getAccessToken() async {
    return await FlutterStorage.storage.read(key: "accessToken");
  }

  static Future<String?> getRefreshToken() async {
    return await FlutterStorage.storage.read(key: "refreshToken");
  }
}
