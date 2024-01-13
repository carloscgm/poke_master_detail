import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialsWallet {
  static const refreshTokenKey = 'refresh_token';
  static const accessTokenKey = 'access_token';
  static const expiresInKey = 'expires_in';

  static getRefreshToken() async {
    return await _getString(refreshTokenKey);
  }

  static getAccessToken() async {
    return await _getString(accessTokenKey);
  }

  static getExpirationTimeStamp() async {
    return await _getInt(expiresInKey);
  }

  static saveRefreshToken(String refreshToken) async {
    await _storeString(refreshTokenKey, refreshToken);
  }

  static saveAccessToken(String refreshToken) async {
    await _storeString(accessTokenKey, refreshToken);
  }

  static saveExpirationTimeStamp(int expiresIn) async {
    // Current date in millis + expiration in millis - 5 minutes in millis
    await _storeInt(expiresInKey,
        (DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000) - 300000));
  }

  static saveAll(dynamic jsonDecode) async {
    await saveRefreshToken(jsonDecode[refreshTokenKey]);
    await saveAccessToken(jsonDecode[accessTokenKey]);
    await saveExpirationTimeStamp(jsonDecode[expiresInKey]);
  }

  static clearAll() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: expiresInKey);
  }

  static _storeString(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static _getString(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key) ?? '';
  }

  static _storeInt(String key, int value) async {
    await _storeString(key, value.toString());
  }

  static _getInt(String key) async {
    final string = await _getString(key);
    return int.tryParse(string) ?? 0;
  }
}
