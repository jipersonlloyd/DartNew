import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/STest.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Controller/AccountController.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.accountController});
  AccountController accountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(81, 58, 54, 1),
      body: GetBuilder(
        init: accountController,
        builder: (_) => Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/image-from-rawpixel-id-12543555-png.png',
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/Logo.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'Email:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: TextField(
                            controller: accountController.emailController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: TextField(
                            controller: accountController.passwordController,
                            obscureText: accountController.isPasswordVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: accountController.toggleVisiblity,
                                icon: Icon(accountController.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 12, 0, 0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.createAccount);
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Color.fromRGBO(223, 113, 66, 1),
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromRGBO(223, 113, 66, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async =>
                              await accountController.login(context),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(223, 113, 66, 1),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Constants.socialMediaButton(
                            'assets/Gmail.png', () {}, 'Continue with Google'),
                        const SizedBox(
                          height: 10,
                        ),
                        Constants.socialMediaButton('assets/Facebook.png',
                            () {}, 'Continue with Facebook'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: accountController.isLoading,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.2)),
                    ),
                    const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
