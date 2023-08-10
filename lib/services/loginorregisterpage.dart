import 'package:flutter/material.dart';

import '../pages/loginpage.dart';
import '../pages/registerpage.dart';

class loginorregisterpage extends StatefulWidget {


  const loginorregisterpage({super.key});

  @override
  State<loginorregisterpage> createState() => _loginorregisterpageState();
}

class _loginorregisterpageState extends State<loginorregisterpage> {
  bool isloginpage = true;

  void togglepage(){
    setState(() {
      isloginpage = !isloginpage;
    });
  }
  Widget build(BuildContext context) {
    if(isloginpage){
      return Loginpage(togglepage: togglepage);
    }
    else{
      return registerpage(togglepage: togglepage);
    }
    
  }
}