import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pages/ApplicationFormNRC.dart';
// import 'package:flutter_application_1/Pages/Money.dart';
// import 'package:flutter_application_1/Pages/Promise.dart';
// import 'package:flutter_application_1/Pages/RulesAndRegulation.dart';
// import 'package:flutter_application_1/Pages/MeterApplyChoice.dart';

//Pages
// import 'dart:html';
import './Pages/Login.dart';
import './Pages/Register.dart';
import './Pages/DivisionChoice.dart';
import './Pages/MeterApplyChoice.dart';
import './Pages/RulesAndRegulation.dart';
import './Pages/Promise.dart';
import './Pages/Money.dart';
import './Pages/ApplicationForm.dart';
import './Pages/ApplicationFormNRC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/divisionChoice': (context) => DivisionChoice(),
        '/meterApply': (context) => MeterApplyChoice(),
        '/Rules': (context) => RulesAndRegulations(),
        '/Promise': (context) => Promise(),
        '/Money': (context) => Money(),
        '/ApplicationForm': (context) => ApplicationForm(),
        '/ApplicationFormNRC': (context) => ApplicationFormNRC(),
      },
    );
  }
}
