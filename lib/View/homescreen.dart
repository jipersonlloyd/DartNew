import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AccountController.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.accountController});
  AccountController accountController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await accountController.getWeatherData(context);
        },
        backgroundColor: Colors.blue,
        child: Center(
          child: Icon(
            Icons.data_array,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                accountController.weatherList.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.loginScreen, (route) => false);
                //get refreshtoken
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder(
        init: accountController,
        builder: (_) {
          if (accountController.weatherList.isEmpty) {
            return Center(
              child: Text('No Data'),
            );
          }
          return ListView.builder(
            itemCount: accountController.weatherList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      const Text('Date: '),
                      Text(accountController.weatherList[index].date),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Temperature Celsius: '),
                      Text(accountController.weatherList[index].date),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Temperature Fahrenheit: '),
                      Text(
                          '${accountController.weatherList[index].temperatureF}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Summary: '),
                      Text(accountController.weatherList[index].summary),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
