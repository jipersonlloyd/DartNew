import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/SAccount.dart';
import 'package:flutter_application_1/API/STest.dart';
import 'package:flutter_application_1/Model/AccountModel.dart';
import 'package:flutter_application_1/Model/LoginModel.dart';
import 'package:flutter_application_1/Model/WeatherModel.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;
  List<WeatherModel> weatherList = [];

  void toggleVisiblity() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> login(BuildContext context) async {
    LoginModel loginModel = LoginModel(
        email: emailController.text, password: passwordController.text);
    if (loginModel.email == '' || loginModel.password == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text('Input Email or Password'),
        ),
      );
      FocusScope.of(context).unfocus();
      return;
    }

    FocusScope.of(context).unfocus();
    await SAccount.loginAccount(loginModel).then(
      (value) async {
        isLoading = true;
        update();

        await Future.delayed(const Duration(seconds: 2)).whenComplete(
          () {
            if (!value['status']) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: value['status'] ? Colors.green : Colors.red,
                  content: Text('${value['message']}'),
                ),
              );
            }
            isLoading = false;
            update();
          },
        );
        if (value['status']) {
          clearTextFields();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeScreen, (route) => false);
        }
      },
    );
  }

  Future<void> createAccount(BuildContext context) async {
    AccountModel accountModel = AccountModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text);

    if (accountModel.email == '' ||
        accountModel.lastName == '' ||
        accountModel.email == '' ||
        accountModel.password == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text('Fields Required'),
        ),
      );
      FocusScope.of(context).unfocus();
      return;
    }

    FocusScope.of(context).unfocus();
    await SAccount.createAccount(accountModel).then(
      (value) async {
        isLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 1)).whenComplete(
          () {
            if (value['status']) {
              clearTextFields();
              Navigator.pop(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                backgroundColor: value['status'] ? Colors.green : Colors.red,
                content: Text('${value['message']}'),
              ),
            );
            isLoading = false;
            update();
          },
        );
      },
    );
  }

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  Future<void> getWeatherData(BuildContext context) async {
    await STest.getWeatherData().then((value) async {
      if (value['status']) {
        weatherList = value['message'];
        update();
      }

      if (value['message'] == 'Unauthorized') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text('Session expired'),
          ),
        );
        await Future.delayed(Duration(seconds: 1)).whenComplete(() {
          Navigator.pushNamed(context, Routes.loadingScreen);
        });
      }
    });
  }
}
