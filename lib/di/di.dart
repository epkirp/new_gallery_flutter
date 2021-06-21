import 'package:dio/dio.dart';
import 'package:domain/gateways/authorization_gateway.dart';
import 'package:domain/gateways/shared_preferences_gateway.dart';
import 'package:gateway/api_constants.dart';
import 'package:gateway/dio_authorization_gateway.dart';
import 'package:gateway/interceptors/token_interceptor.dart';
import 'package:gateway/shared_preferences_gateway_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injection = GetIt.instance;

Future<void> setUpInjections() async {
  Dio dio = Dio();
  dio.options.baseUrl = ApiConstants.baseUrl;

  injection.registerLazySingleton<Dio>(() => dio);

  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //Gateways
  injection.registerLazySingleton<SharedPreferencesGateway>(() => SharedPreferencesGatewayImpl(injection()));
  injection.registerLazySingleton<AuthorizationGateway>(() => DioAuthorizationGateway(dio));

  dio
    ..interceptors.add(TokenInterceptor(
      authorizationGateway: injection(),
      sharedPreferencesGateway: injection(),
      dio: dio,
    ))
    ..interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
}
