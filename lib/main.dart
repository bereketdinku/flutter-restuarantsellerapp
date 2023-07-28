import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const/const.dart';
import 'views/auth_screen/login_screen.dart';
import 'views/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedin = false;
  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      isLoggedin = false;
      if (user == null && mounted) {
        isLoggedin = false;
      } else {
        isLoggedin = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0.0)),
      home: isLoggedin ? const Home() : const LoginScreen(),
    );
  }
}
