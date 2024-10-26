import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/SLogin.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;

  void toggleVisiblity() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<void> login(BuildContext context) async {
    if (emailController.text == '' || passwordController.text == '') {
      FocusScope.of(context).unfocus();
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
    await SLogin.loginAccount(emailController.text, passwordController.text)
        .then(
      (value) async {
        isLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 1)).whenComplete(
          () {
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
}
