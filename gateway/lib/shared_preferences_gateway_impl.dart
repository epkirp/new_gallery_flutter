import 'package:domain/gateways/shared_preferences_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesGatewayImpl implements SharedPreferencesGateway {
  final SharedPreferences sharedPreferences;
  static const _accessTokenKey = "access_token";
  static const _refreshTokenKey = "refresh_token";
  static const _clientIdKey = "client_id";
  static const _clientSecretKey = "client_secret";

  SharedPreferencesGatewayImpl(this.sharedPreferences);

  @override
  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }

  @override
  String getAccessToken() {
    return sharedPreferences.getString(_accessTokenKey) ?? "";
  }

  @override
  String getRefreshToken() {
    return sharedPreferences.getString(_refreshTokenKey) ?? "";
  }

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(_refreshTokenKey, refreshToken);
  }

  @override
  String getClientId() {
    return sharedPreferences.getString(_clientIdKey) ?? "";
  }

  @override
  String getClientSecret() {
    return sharedPreferences.getString(_clientSecretKey) ?? "";
  }

  @override
  Future<void> saveClientData({required String clientId, required String clientSecret}) async {
    await sharedPreferences.setString(_clientIdKey, clientId);
    await sharedPreferences.setString(_clientSecretKey, clientSecret);
  }
}
