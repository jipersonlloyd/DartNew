import 'package:flutter/material.dart';

class Constants {
  static Widget socialMediaButton(
          String image, Function() function, String text) =>
      GestureDetector(
        onTap: function,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Image.asset(image),
              const SizedBox(width: 5),
              Text(text),
            ],
          ),
        ),
      );
}
