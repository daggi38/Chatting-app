import 'package:flutter/material.dart';
import 'package:mychat/components/drawertile.dart';

class mydrawer extends StatelessWidget {
  final String email;
  final String inital;
  const mydrawer({super.key, required this.email, required this.inital});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 73, 76, 78),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                          height: 70,
                          width: 70,
                          color: Color.fromARGB(255, 172, 200, 200),
                          child: Center(
                              child: Text(inital
                                  .toString()
                                  .characters
                                  .first
                                  .toUpperCase()))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      email,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Drawertile(listtitle: "New Group"),
            Drawertile(listtitle: "New Chat"),
            Drawertile(listtitle: "New channe;"),
            Drawertile(listtitle: "Contacts"),
            Drawertile(listtitle: "Folders"),
            Drawertile(listtitle: "Saved"),
          ],
        ),
      ),
    );
  }
}
