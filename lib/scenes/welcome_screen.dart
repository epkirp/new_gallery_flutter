import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway/dio_authorization_gateway.dart';
import 'package:new_gallery/resources/app_assets.dart';
import 'package:new_gallery/resources/app_strings.dart';
import 'package:new_gallery/scenes/sign_in/sign_in_bloc.dart';
import 'package:new_gallery/scenes/sign_in/sign_in_screen.dart';
import 'package:new_gallery/scenes/sign_up/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
              child: Text(
                AppStrings.welcome,
                style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () => _openSingUpScreen(context),
                child: Text(
                  AppStrings.createAccount,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => _openSingInScreen(context),
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openSingInScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [BlocProvider(create: (_) => SignInBloc(DioAuthorizationGateway()))],
          child: SignInScreen(),
        ),
      ),
    );
  }

  _openSingUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpScreen()));
  }
}
