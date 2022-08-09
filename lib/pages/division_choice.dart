import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/meter_apply_choice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DivisionChoice extends StatefulWidget {
  const DivisionChoice({Key? key}) : super(key: key);

  @override
  State<DivisionChoice> createState() => _DivisionChoiceState();
}

class _DivisionChoiceState extends State<DivisionChoice> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = sharedPrefs;
    });
    var token = prefs!.getString('token');
    checkToken(token);
  }

  void checkToken(token) async {
    var apiPath = prefs!.getString('api_path');
    var url = Uri.parse('${apiPath}api/check_token');
    try {
      var response = await http.post(url, body: {'token': token});
      Map data = jsonDecode(response.body);
      if (!data['success']) {
        logout();
      }
    } catch (e) {
      showAlertDialog(
          'Connection Failed!', 'Check your internet connection', context);
      print('check token error $e');
    }
  }

  AppBar applicationBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        "မီတာလျှောက်လွှာပုံစံများ",
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget divisionLink(String title, VoidCallback _onTapfun) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14.0),
        ),
        leading: const Icon(Icons.map),
        trailing: InkWell(
          onTap: _onTapfun,
          child: const Icon(Icons.arrow_circle_right),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ));
  }

  Widget body(BuildContext context) {
    return Scaffold(
      appBar: applicationBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            divisionLink("ရန်ကုန်တိုင်းဒေသကြီးတွင် \n မီတာလျှောက်ထားခြင်း", () {
              Navigator.pushNamed(context, '/meter_apply');
            }),
            const SizedBox(height: 10.0),
            divisionLink(
                "မန္တလေးတိုင်းဒေသကြီးတွင် \n မီတာလျှောက်ထားခြင်း", () {}),
            const SizedBox(height: 10.0),
            divisionLink(
                "အခြားတိုင်းဒေသကြီး/ပြည်နယ်များတွင် \n မီတာလျှောက်ထားခြင်း",
                () {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  void logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    setState(() {
      pref.clear();
      pref.commit();
    });
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }

  void showAlertDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CLOSE'),
              )
            ],
          );
        });
  }
}
