// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/components/button.dart';
import 'package:mychat/components/textfields.dart';

import 'package:mychat/services/authservices.dart';
import 'package:mychat/services/obsecure.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  void Function()? togglepage;

  Loginpage({super.key, required this.togglepage});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool myobsecure = true;
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  void signin() {
    final authservice = Provider.of<Authservice>(context, listen: false);
    authservice.signIn(emailcontroller.text, passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    final isshowing = Provider.of<isobsecure>(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " My Chat",
                  style: GoogleFonts.abel(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                textfields(
                    ontap: () {},
                    suffixicon: false,
                    hinttext: "Email",
                    obscuretext: false,
                    controller: emailcontroller),
                SizedBox(
                  height: 15,
                ),
                textfields(
                    ontap: () {
                      isshowing.show();
                    },
                    suffixicon: true,
                    hinttext: "Password",
                    obscuretext: isshowing.showing,
                    controller: passwordcontroller),
                SizedBox(
                  height: 20,
                ),
                Mybutton(
                    title: "Login",
                    onpressed: () {
                      signin();
                      print("object");
                    }),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Donot have an account ?"),
                    GestureDetector(
                        onTap: widget.togglepage, child: Text("Register now"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}