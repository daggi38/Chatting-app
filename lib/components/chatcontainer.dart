// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Chatcontainer extends StatelessWidget {
  void Function()? onTap;

  String message;
  var mycolor;
  String thetimestamp;
  Chatcontainer({
    super.key,
    required this.message,
    required this.mycolor,
    required this.thetimestamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onTap,
      child: Container(
          constraints: BoxConstraints(maxWidth: 200),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: mycolor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(message),
              Row(
                children: [
                  Text(thetimestamp, style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          )),
    );
  }
}
