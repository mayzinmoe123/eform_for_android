import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/residential/Overview.dart';
import 'package:flutter_application_1/pages/yangon/residential/r06_household.dart';
import 'package:flutter_application_1/pages/yangon/residential/r07_recommend.dart';
import 'package:flutter_application_1/pages/yangon/residential/r08_ownership.dart';
import 'package:flutter_application_1/pages/yangon/residential/r09_farmland.dart';
import 'package:flutter_application_1/pages/yangon/residential/r10_building.dart';
import 'package:flutter_application_1/pages/yangon/residential/r11_power.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Authentication
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

// division choice
import 'package:flutter_application_1/pages/division_choice.dart';

// Yangon
import 'package:flutter_application_1/pages/yangon/meter_apply_choice.dart';
// Yangon > Residential
import 'package:flutter_application_1/pages/yangon/residential/r01_rules.dart';
import 'package:flutter_application_1/pages/yangon/residential/r02_promise.dart';
import 'package:flutter_application_1/pages/yangon/residential/r03_money.dart';
import 'package:flutter_application_1/pages/yangon/residential/r04_info.dart';
import 'package:flutter_application_1/pages/yangon/residential/r05_nrc.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/division_choice': (context) => DivisionChoice(),

        // Yangon
        '/yangon/meter': (context) => MeterApplyChoice(),
        // Residential
        '/yangon/residential/r01_rules': (context) => R01Rules(),
        '/yangon/residential/r02_promise': (context) => R02Promise(),
        '/yangon/residential/r03_money': (context) => R03Money(),
        '/yangon/residential/r04_info': (context) => R04Info(),
        '/yangon/residential/r05_nrc': (context) => R05Nrc(),
        '/yangon/residential/r06_household': (context) => R06HouseHold(),
        '/yangon/residential/r07_recommend': (context) => R07Recommend(),
        '/yangon/residential/r08_ownership': (context) => R08Ownership(),
        '/yangon/residential/r09_farmland': (context) => R09Farmland(),
        '/yangon/residential/r10_building': (context) => R10Building(),
        '/yangon/residential/r11_power': (context) => R11Power(),
        '/yangon/residential/overview': (context) => Overview()
      },
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pyidaungsu'),
    );
  }
}
