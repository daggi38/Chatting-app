import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mychat/firebase_options.dart';

import 'package:mychat/services/authgate.dart';
import 'package:mychat/services/authservices.dart';
import 'package:mychat/services/chat/showscroll.dart';

import 'package:mychat/services/obsecure.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<scrrollfromup>(create: (context) => scrrollfromup(),),
        ChangeNotifierProvider<isobsecure>(create: (context) => isobsecure()),
        ChangeNotifierProvider<Authservice>(create: (context) => Authservice()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Authgate());
  }
}
