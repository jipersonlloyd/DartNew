import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AccountController.dart';
import 'package:flutter_application_1/View/loginscreen.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() {
    Get.put(AccountController());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.loginScreen,
      routes: {Routes.loginScreen: (context) => LoginScreen()},
    );
  }
}
