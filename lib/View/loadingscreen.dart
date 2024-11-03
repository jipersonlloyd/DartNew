import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/SRefreshToken.dart';
import 'package:flutter_application_1/Controller/AccountController.dart';
import 'package:flutter_application_1/routes.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key, required this.accountController});
  AccountController accountController;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await Future.delayed(Duration(seconds: 5));
    await SRefreshToken.getAccessToken().then((value) {
      if (value['status']) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeScreen, (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text('Session restored'),
          ),
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
