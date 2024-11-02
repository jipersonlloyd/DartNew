import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AccountController.dart';
import 'package:flutter_application_1/View/createaccount.dart';
import 'package:flutter_application_1/View/homescreen.dart';
import 'package:flutter_application_1/View/loadingscreen.dart';
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
  late AccountController accountController;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() {
    accountController = Get.put(AccountController());
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
      routes: {
        Routes.loginScreen: (context) => LoginScreen(
              accountController: accountController,
            ),
        Routes.createAccount: (context) => CreateAccount(
              accountController: accountController,
            ),
        Routes.homeScreen: (context) => HomeScreen(
              accountController: accountController,
            ),
        Routes.loadingScreen: (context) =>
            LoadingScreen(accountController: accountController),
      },
    );
  }
}
