import 'package:flutter/material.dart';

class profilecontainer extends StatefulWidget {
  final email;
  final username;
  final bio;

  profilecontainer({
    super.key,
    required this.email,
    required this.username,
    required this.bio,
  });

  @override
  State<profilecontainer> createState() => _profilecontainerState();
}

class _profilecontainerState extends State<profilecontainer> {
  bool isenlarged = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        child: Container(
          height: 200,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Email ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              widget.email,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 94, 142, 232)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Username ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Text(
              widget.username,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 94, 142, 232)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Bio ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  widget.bio,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 94, 142, 232)),
                ),
              ],
            ),
          ]),
        ));
  }
}
