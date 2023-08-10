// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class textfields extends StatelessWidget {
  String hinttext;
  bool obscuretext;
  bool suffixicon;
  final Function ontap;

  final TextEditingController controller;
  textfields(
      {super.key,
      required this.hinttext,
      required this.obscuretext,
      required this.controller,
      required this.ontap,
      required this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
            suffixIcon: suffixicon
                ? GestureDetector(
                    onTap: () {
                      ontap();
                    },
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ))
                : null,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey[200]),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 15, offset: Offset(10, 10)),
        BoxShadow(color: Colors.white, blurRadius: 15, offset: Offset(-10, -10))
      ]),
    );
  }
}
