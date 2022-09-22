import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MeterApplyChoice extends StatefulWidget {
  const MeterApplyChoice({Key? key}) : super(key: key);

  @override
  State<MeterApplyChoice> createState() => _MeterApplyChoiceState();
}

class _MeterApplyChoiceState extends State<MeterApplyChoice> {
  bool isLoading = true;
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
        refreshToken(data['token']);
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

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? loading() : Scaffold(
      appBar: applicatonBar(context),
      body: body(context),
    );
  }

  AppBar applicatonBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "မီတာလျှောက်ထားခြင်း",
        style: TextStyle(fontSize: 18.0),
      ),
      actions: [
        IconButton(
          onPressed: () {
            goToHomePage(context);
          },
          icon: Icon(Icons.home),
        )
      ],
    );
  }

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

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Column(
          children: [
            _getMeterlist("အိမ်သုံးမီတာ လျှောက်ထားခြင်း", Icons.home,
                'mdy_r_form01_rules'),
            _getMeterlist("အိမ်သုံးပါဝါမီတာ လျှောက်ထားခြင်း",
                Icons.electric_meter, 'mdy_rp_form01_rules'),
            _getMeterlist("စက်မှုသုံးပါဝါမီတာ လျှောက်ထားခြင်း",
                Icons.construction, 'mdy_cp_form01_rules'),
            _getMeterlist("ကန်ထရိုက်တိုက် မီတာလျှောက်ထားခြင်း",
                Icons.business_center, 'mdy_c_form01_rules'),
            _getMeterlist("ထရန်စဖော်မာ လျှောက်ထားခြင်း",
                Icons.flash_on_outlined, 'mdy_t_form01_rules'),
            // _getMeterlist("ကျေးရွာမီးလင်းရေး", Icons.lightbulb_circle,
            //     '/yangon/residential/r01_rules'),
          ],
        ),
      ),
    );
  }

  Widget _getMeterlist(String name, IconData icon, String navName) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
      child: Card(
          child: ListTile(
        title: Text(name, style: TextStyle(fontSize: 14.0)),
        leading: Icon(
          icon,
          size: 15.0,
        ),
        trailing: Icon(
          Icons.double_arrow,
          size: 14.0,
          color: Colors.blue,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onTap: () {
          Navigator.pushNamed(context, navName);
        },
      )),
    );
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

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
