// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/components/textfields.dart';
import 'package:mychat/services/authservices.dart';
import 'package:mychat/services/obsecure.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';

class registerpage extends StatefulWidget {
  void Function() togglepage;

  registerpage({super.key, required this.togglepage});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  bool myobscuretext = true;

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  void register() {
    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      try {
        final authservice = Provider.of<Authservice>(context, listen: false);
        authservice.Signupwithemailandpassword(
            emailcontroller.text, passwordcontroller.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Email already in use try another")));
        } else
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Password and Confirm Password does not match")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isshowing = Provider.of<isobsecure>(context);
    final show = isshowing.showing;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register now",
              style:
                  GoogleFonts.abel(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            textfields(
                ontap: () {},
                suffixicon: false,
                hinttext: "Email",
                obscuretext: false,
                controller: emailcontroller),
            const SizedBox(
              height: 15,
            ),
            textfields(
                ontap: () {
                  isshowing.show();
                },
                suffixicon: true,
                hinttext: "Password",
                obscuretext: show,
                controller: passwordcontroller),
            const SizedBox(
              height: 15,
            ),
            textfields(
                ontap: () {
                  isshowing.show();
                },
                suffixicon: true,
                hinttext: "Confirm Password",
                obscuretext: myobscuretext,
                controller: confirmpasswordcontroller),
            const SizedBox(
              height: 15,
            ),
            Mybutton(
                title: "Register",
                onpressed: () {
                  register();
                }),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account ?"),
                GestureDetector(
                    onTap: widget.togglepage, child: const Text("Login now"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
