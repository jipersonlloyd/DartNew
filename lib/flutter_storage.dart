import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
}
