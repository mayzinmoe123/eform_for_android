import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/reset_password.dart';
import 'package:flutter_application_1/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Authentication
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

// division choice
import 'package:flutter_application_1/pages/division_choice.dart';

import 'yangon.dart';
import 'mandalay.dart';
import 'other.dart';

void main()async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  // print(token);
  runApp(MyApp(token: token,));
} 

class MyApp extends StatefulWidget {
  final String? token;
  const MyApp({Key? key,this.token}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(token);
}

class _MyAppState extends State<MyApp> {
  String? token;

  _MyAppState(this.token);

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  // upload_img_bk_22_11_21

  initializePrefs() async {
    try{
      // for production
      var url = Uri.parse('https://moep.gov.mm/api/MoepAppController/eform_path');
      var response = await http.post(url, body: {});
      Map data = jsonDecode(response.body);
      print('data $data');

      if (data['success'] == true) {
        String apiPath = data['path'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('api_path', apiPath);
        setState(() {
          prefs.setString('api_path', apiPath);
        });
        print('main apiPath $apiPath');
      }
    }catch(e){
      print('exception for moep $e');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_path', 'https://eform.moee.gov.mm/');
      setState(() {
        prefs.setString('api_path', 'https://eform.moee.gov.mm/');
      });
      print('main apiPath https://eform.moee.gov.mm/');
    }
  }

  Map<String, Widget Function(BuildContext)> getAllLinks(BuildContext context) {
    Map<String, Widget Function(BuildContext)> allLink = {};


    Map<String, Widget Function(BuildContext)> initialLink = {
      '/': (context) =>  token == null ? Login() : DivisionChoice() ,
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

  // loading widget ----- start
  Widget loading() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            Text('လုပ်ဆောင်နေပါသည်။ ခေတ္တစောင့်ဆိုင်းပေးပါ။')
          ],
        ),
      ),
    );
  }
  // loading widget ----- end

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

}


