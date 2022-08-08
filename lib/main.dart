import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';
import 'package:flutter_application_1/pages/yangon/residential/application_form.dart';
import 'package:flutter_application_1/pages/yangon/residential/application_form_n_r_c.dart';
import 'package:flutter_application_1/pages/yangon/residential/division_choice.dart';
import 'package:flutter_application_1/pages/yangon/residential/meter_apply_choice.dart';
import 'package:flutter_application_1/pages/yangon/residential/money.dart';
import 'package:flutter_application_1/pages/yangon/residential/promise.dart';
import 'package:flutter_application_1/pages/yangon/residential/rules_and_regulation.dart';

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
