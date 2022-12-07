import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/account_header.dart';
import 'package:flutter_application_1/utils/account_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name');
      email = prefs.getString('user_email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              AccountHeader(name ?? '', email ?? ''),
              // AccountLink(Icons.person_outline, 'မိမိအကောင့်', goToAccountInfo),
              // AccountLink(
              //     Icons.key_outlined, 'စကားဝှက်ပြောင်းလဲရန်', goToAccountInfo),
              AccountLink(
                  Icons.exit_to_app_outlined, 'အကောင့်မှထွက်မည်', loginClick),
              AccountLink(
                  Icons.delete_forever, 'အကောင့်ဖျက်သိမ်းမည်', accDelClick),
                AccountLink(
                  Icons.settings, 'ပြင်ဆင်ရန်', userSetting),
            ]),
          )
        ],
      ),
    );
  }

  void loginClick() {
    showAlertDialog('အကောင့်ထွက်မည်လား',
        'အကောင့်ထွက်ရန်သေချာပါက LOG OUT ကိုနှိပ်ပါ။', context);
  }

  void accDelClick() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    String apiPath = prefs.getString('api_path').toString();
    try{
      var url = '${apiPath}accountDeletion';
      if (await canLaunch(url))
        await launch(url);
      else
        throw "Could not launch $url";
    } on SocketException catch (e) {
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
      print('check token error $e');
    }on Exception catch (e) {
      logout();
    }
  }

  void userSetting(){
     Navigator.pushNamedAndRemoveUntil(
        context, '/user_setting', (route) => false);
  }

  void showAlertDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: logoutButton(),
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
        context, '/login', (Route<dynamic> route) => false);
  }
}
