import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = "auth_token";
  static const _keyTimestamp = "token_timestamp";
  static const tokenDuration = Duration(days: 1);

  static Future<void> saveToken(String token) async {
    final timestamp = DateTime.now().toIso8601String();
    await _storage.write(key: _keyToken, value: token);
    await Future.wait([
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyTimestamp, value: timestamp),
    ]);
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _keyToken);
    final timestamp = await _storage.read(key: _keyTimestamp);

    if (token == null || timestamp == null) {
      return null;
    }

    final creationDate = DateTime.parse(timestamp);
    final now = DateTime.now();

    if (now.difference(creationDate) > tokenDuration) {
      await deleteToken();
      return null;
    }

    return token;
  }

  static Future<void> deleteToken() async {
    await Future.wait([
      _storage.delete(key: _keyToken),
      _storage.delete(key: _keyTimestamp),
    ]);
  }

  static Future<bool> checkLoginStatus() async {
    final String? key = await _storage.read(key: _keyToken);

    if (key == null){
      return false;
    }

    return true;
  }
}
