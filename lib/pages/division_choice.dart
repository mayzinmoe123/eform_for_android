import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/account_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DivisionChoice extends StatefulWidget {
  const DivisionChoice({Key? key}) : super(key: key);

  @override
  State<DivisionChoice> createState() => _DivisionChoiceState();
}

class _DivisionChoiceState extends State<DivisionChoice> {
  int selectedBottom = 0;
  bool isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var apiPath = prefs.getString('api_path');
    var url = Uri.parse('${apiPath}api/check_token');
    try {
      var response = await http.post(url, body: {'token': token});
      Map data = jsonDecode(response.body);
      if (data['success'] == true) {
        stopLoading();
      } else {
        stopLoading();
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      print('http error $e');
      stopLoading();
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: applicationBar(context),
      body: isLoading ? loading() : body(context),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dataset), label: 'လျှောက်လွှာပုံစံများ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sort), label: 'လုပ်ငန်းစဉ်အားလုံး'),
        ],
        currentIndex: selectedBottom,
        onTap: (value) {
          setState(() {
            selectedBottom = value;
          });
        },
      ),
      endDrawer: AccountSetting('may', 'email'),
    );
  }

  AppBar applicationBar(
    BuildContext context,
  ) {
    return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "မီတာလျှောက်လွှာပုံစံများ",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.manage_accounts),
              onPressed: () {
                print('open end drawer');
                scaffoldKey.currentState?.openEndDrawer();
              }),
        ]);
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text('လုပ်ဆောင်နေပါသည်။ ခေတ္တစောင့်ဆိုင်းပေးပါ။')
      ],
    );
  }

  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          divisionLink("ရန်ကုန်တိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း", () {
            Navigator.pushNamed(context, '/yangon/meter');
          }),
          const SizedBox(height: 10.0),
          divisionLink("မန္တလေးတိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း", () {}),
          const SizedBox(height: 10.0),
          divisionLink(
              "အခြားတိုင်းဒေသကြီး/ပြည်နယ်များတွင် မီတာလျှောက်ထားခြင်း", () {}),
        ],
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
          style: const TextStyle(fontSize: 16.0),
        ),
        leading: const Icon(Icons.map),
        trailing: InkWell(
          onTap: _onTapfun,
          child: const Icon(Icons.arrow_circle_right, color: Colors.blue),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ));
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
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
                child: title != 'Unauthorized' ? Text('CLOSE') : logoutButton(),
              )
            ],
          );
        });
  }

  Widget logoutButton() {
    return GestureDetector(
      child: Text('LOG OUT'),
      onTap: () {
        logout();
      },
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }
}
