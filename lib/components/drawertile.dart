import 'package:flutter/material.dart';

class Drawertile extends StatelessWidget {
  final String listtitle;
   Drawertile({super.key, required this.listtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        listtitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
