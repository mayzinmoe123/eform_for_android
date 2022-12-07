import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class R03Money extends StatefulWidget {
  const R03Money({Key? key}) : super(key: key);

  @override
  State<R03Money> createState() => _R03MoneyState();
}

class _R03MoneyState extends State<R03Money> {
  int? formId;
  bool isLoading = false;
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
    if (data['edit'] != null) {
      setState(() {
        edit = data['edit'];
      });
    }
    return isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body:  body(context),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
    );
  }

  AppBar applicationBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          goToBack();
        },
      ),
      centerTitle: true,
      title: Text("ကောက်ခံမည့်နှုန်းများ", style: TextStyle(fontSize: 18.0)),
      actions: [
        IconButton(
          onPressed: () {
            goToHomePage(context);
          },
          icon: Icon(Icons.home),
        ),
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                color: Colors.black,
              ),
              children: [
                _getTableHeader(
                    "အကြောင်းအရာများ",
                    "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)",
                    "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)",
                    "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                _getTableHeader(
                    "အကြောင်းအရာများ",
                    "Type One (5/30A) ကျေးလက်ဒေသသုံးမီတာ",
                    "Type Two (5/30A) (HHU) မြို့ငယ်သုံးမီတာ",
                    "Type Three (10/60A) (HHU) မြို့ကြီးသုံးမီတာ"),
                getTableBodyDetail(
                    "မီတာသတ်မှတ်ကြေး", "၃၅,၀၀၀", "၆၅,၀၀၀", "၈၀,၀၀၀"),
                getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀", "၄,၀၀၀", "၄,၀၀၀"),
                getTableBodyDetail(
                    "လိုင်းကြိုး (ဆက်သွယ်ခ)", "၄,၀၀၀", "၄,၀၀၀", "၄,၀၀၀"),
                getTableBodyDetail("မီးဆက်ခ", "၂,၀၀၀", "၂,၀၀၀", "၂,၀၀၀"),
                getTableBodyDetail("ကြီးကြပ်ခ", "၁,၀၀၀", "၁,၀၀၀", "၁,၀၀၀"),
                getTableBodyDetail(
                    "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၁,၀၀၀", "၁,၀၀၀", "၁,၀၀၀"),
                getTableBodyDetail("စုစုပေါင်း", "၄၅,၀၀၀", "၇၅,၀၀၀", "၉၀,၀၀၀"),
                _getChooseBtn(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  TableRow _getTableHeader(d1, d2, d3, d4) {
    return TableRow(children: [
      _getTableHeaderDetail(d1),
      _getTableHeaderDetail(d2),
      _getTableHeaderDetail(d3),
      _getTableHeaderDetail(d4),
    ]);
  }

  Container _getTableHeaderDetail(data) {
    return Container(
      // height: 70,
      child: Center(
          child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    );
  }

  Container _getTableBody(name) {
    return Container(
      // height: 70,
      padding: EdgeInsets.all(14),
      child: Text(
        name,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.left,
      ),
    );
  }

  TableRow getTableBodyDetail(d1, d2, d3, d4) {
    return TableRow(children: [
      _getTableBody(
        d1,
      ),
      _getTableBody(d2),
      _getTableBody(d3),
      _getTableBody(d4),
    ]);
  }

  TableRow _getChooseBtn() {
    return TableRow(children: [
      Text(""),
      _makeChooseBtn('1'),
      _makeChooseBtn('2'),
      _makeChooseBtn('3'),
    ]);
  }

   Widget _makeChooseBtn(String type) {
    return Container(
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        onPressed: () {
          meterTypeSave(type);
        },
        // style: OutlinedBorder(),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Icon(Icons.check, color: Colors.white, size: 20),
      ),
    );
  }

  void meterTypeSave(String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiPath = pref.getString("api_path").toString();
    String token = pref.getString("token").toString();
    try {
      print("old token is $token");
      var url = Uri.parse("${apiPath}api/meter_type");
      var response = await http.post(url, body: {
        'token': token,
        'form_id': formId != null ? formId.toString() : '',
        'apply_type': '1', // residential meter
        'apply_division': '2', // ygn = 1, mdy = 3, other=2
        'apply_sub_type': type,
      });
      Map data = jsonDecode(response.body);
      print('meter saving result $data');
      if (data['success']) {
        stopLoading();
        setState(() {
          formId = data['form']['id'];
        });
        refreshToken(data['token']);
        goToNextPage();
      } else {
        stopLoading();
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      stopLoading();
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
      print('check token error $e');
    } on Exception catch (e) {
      logout();
    }
  }

 void stopLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startLoading() {
    if(this.mounted){
      setState(() {
      isLoading = true;
    });
    }
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
        context, '/login', (Route<dynamic> route) => false);
  }

  void goToBack() {
    Navigator.of(context).pop(formId);
  }

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  void goToNextPage() async {
    if (edit) {
      goToBack();
    } else {
      final result = await Navigator.pushNamed(context, 'other_r04_info',
          arguments: {'form_id': formId});
      setState(() {
        formId = (result ?? 0) as int;
      });
      print('money form id is $formId');
    }
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
