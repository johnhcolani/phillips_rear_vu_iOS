// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillips_rear_vu/screens/login_page.dart';
import 'package:phillips_rear_vu/screens/my_app.dart';
import 'package:phillips_rear_vu/screens/scanner_page.dart';
import 'package:phillips_rear_vu/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (cintext, orientation, deviceType){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            routes: {
              '/': (context) => LoginPage(),
              '/MyApp': (context) => const MyAppView(),
              '/scanner': (context) => const ScannerPage(),
              '/splash': (context) => SplashScreen(),
              // '/webview': (context) => WebviewCheck(),

            }
        );
      }
    );
  }
}
