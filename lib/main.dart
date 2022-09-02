import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/reset_password.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Authentication
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

// division choice
import 'package:flutter_application_1/pages/division_choice.dart';

import 'yangon.dart';
import 'mandalay.dart';
import 'other.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  initializePrefs() async {
    // String apiPath = "http://localhost/eform/public/";
    String apiPath = "http://192.168.99.124/eform/public/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('api_path', apiPath);
    });
  }

  Map<String, Widget Function(BuildContext)> getAllLinks(BuildContext context) {
    Map<String, Widget Function(BuildContext)> allLink = {};
    Map<String, Widget Function(BuildContext)> initialLink = {
      '/': (context) => Login(),
      '/login': (context) => Login(),
      '/register': (context) => Register(),
      '/reset_password': (context) => ResetPassword(),
      '/division_choice': (context) => DivisionChoice(),
    };
    allLink.addAll(initialLink);

    Yangon yangon = Yangon();
    Map<String, Widget Function(BuildContext)> yangonLink =
        yangon.link(context);
    allLink.addAll(yangonLink);

    Mandalay mandalay = Mandalay();
    Map<String, Widget Function(BuildContext)> mandalayLink =
        mandalay.link(context);
    allLink.addAll(mandalayLink);

    Other other = Other();
    Map<String, Widget Function(BuildContext)> otherLink = other.link(context);
    allLink.addAll(otherLink);

    return allLink;
  }

  @override
  Widget build(BuildContext context) {
    var allLinks = getAllLinks(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: allLinks,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pyidaungsu'),
    );
  }
}
