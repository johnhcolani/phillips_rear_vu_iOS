// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phillips_rear_vu/screens/my_app.dart';
import 'package:phillips_rear_vu/screens/scanner_page.dart';
import 'package:phillips_rear_vu/screens/splash_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/MyApp': (context) => const MyAppView(),
        '/scanner': (context) => const ScannerPage(),
        // '/webview': (context) => WebviewCheck(),
      },
    ),
  );
}
