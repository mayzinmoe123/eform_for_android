import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';
import 'package:flutter_application_1/pages/division_choice.dart';
import 'package:flutter_application_1/pages/yangon/meter_apply_choice.dart';
import 'package:flutter_application_1/pages/yangon/residential/application_form.dart';
import 'package:flutter_application_1/pages/yangon/residential/application_form_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/residential/money.dart';
import 'package:flutter_application_1/pages/yangon/residential/promise.dart';
import 'package:flutter_application_1/pages/yangon/residential/rules_and_regulation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiPath = prefs.getString('api_path');
    setState(() {
      // String apiPath = "http://localhost/eform/public/";
      String apiPath = "http://192.168.99.183/eform/public/";
      prefs.setString('api_path', apiPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/division_choice': (context) => DivisionChoice(),
        '/meter_apply': (context) => MeterApplyChoice(),
        '/rules': (context) => RulesAndRegulations(),
        '/promise': (context) => Promise(),
        '/money': (context) => Money(),
        '/application_form': (context) => ApplicationForm(),
        '/application_form_nrc': (context) => ApplicationFormNRC(),
      },
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pyidaungsu'),
    );
  }
}
