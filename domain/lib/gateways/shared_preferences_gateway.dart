abstract class SharedPreferencesGateway {
  String getAccessToken();

  String getRefreshToken();

  String getClientId();

  String getClientSecret();

  Future<void> saveTokens({required String accessToken, required String refreshToken});

  Future<void> saveClientData({required String clientId, required String clientSecret});

  Future<void> clearAllData();
}
