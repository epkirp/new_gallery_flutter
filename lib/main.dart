import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_gallery/di/di.dart';
import 'package:new_gallery/resources/app_strings.dart';
import 'package:new_gallery/scenes/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpInjections();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (e, stackTrace) {});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomeScreen(),
    );
  }
}
