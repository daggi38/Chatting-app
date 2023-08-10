// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  String title;
  void Function() onpressed;
  Mybutton({super.key, required this.title, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 15, offset: Offset(10, 10)),
            BoxShadow(
                color: Colors.white, blurRadius: 15, offset: Offset(-10, -10))
          ],
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        )),
      ),
    );
  }
}
