import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form04_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RpForm03Money extends StatefulWidget {
  const RpForm03Money({Key? key}) : super(key: key);

  @override
  State<RpForm03Money> createState() => _RpForm03MoneyState();
}

class _RpForm03MoneyState extends State<RpForm03Money> {
  int? formId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ကောက်ခံမည့်နှုန်းများ"),
      ),
      body: SingleChildScrollView(
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
                      "အကြောင်းအရာများ", "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                  getTableBodyDetail("မီတာသတ်မှတ်ကြေး", "၈၀၀,၀၀၀","၁,၀၀၀,၀၀၀","၁,၂၀၀,၀၀၀"),
                  getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀","၄,၀၀၀","၄,၀၀၀"),
                  getTableBodyDetail("လိုင်းကြိုး (ဆက်သွယ်ခ)", "၄,၀၀၀","၄,၀၀၀","၄,၀၀၀"),
                  getTableBodyDetail("မီးဆက်ခ", "၂,၀၀၀", "၂,၀၀၀", "၂,၀၀၀"),
                  getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၂,၀၀၀", "၂,၀၀၀", "၂,၀၀၀"),
                   getTableBodyDetail("composit box", "၄၀,၀၀၀", "၄၀,၀၀၀", "၄၀,၀၀၀"),
                  getTableBodyDetail("စုစုပေါင်း", "၈၅၂,၀၀၀","၁,၀၅၂,၀၀၀","၁,၂၅၂,၀၀၀"),
                  _getChooseBtn(),
                  // TableRow(children: [
                  //   ElevatedButton(onPressed: () {}, child: Text("ရွေးချယ်မည်")),
                  // ])
                ],
              ),
              SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ),
    );
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

  TableRow _getTableHeader(d1, d2) {
    return TableRow(children: [
      _getTableHeaderDetail(d1),
      _getTableHeaderDetail(d2),
      _getTableHeaderDetail(d2),
      _getTableHeaderDetail(d2),
    ]);
  }

  Container _getTableHeaderDetail(data) {
    return Container(
      // height: 70,
      child: Center(
          child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,
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

  TableRow getTableBodyDetail(d1, d2,d3,d4) {
    return TableRow(children: [
      _getTableBody(d1,),
      _getTableBody(d2),
      _getTableBody(d3),
      _getTableBody(d4),
    ]);
  }
  TableRow _getChooseBtn(){
    return TableRow(
     children: [
        Text(""),
        _makeChooseBtn(),
        _makeChooseBtn(),
        _makeChooseBtn(),
             
     ]
    );
  }
  Widget _makeChooseBtn(){
    return Container(
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
                onPressed: () {
                 startLoading();
            meterTypeSave();
                },
                // style: OutlinedBorder(),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),),
                child: Text("ရွေးချယ်မည်",style: TextStyle(fontSize: 8),),
              ),
    );
  }

   void meterTypeSave() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiPath = pref.getString("api_path").toString();
    String token = pref.getString("token").toString();
    try {
      print("old token is $token");
      var url = Uri.parse("${apiPath}api/yangon/residential_meter_type");
      var response = await http.post(url, body: {
        'token': token,
        'form_id': formId != null ? formId.toString() : ''
      });
      Map data = jsonDecode(response.body);
      print('meter saving result $data');
      if (data['success']) {
        stopLoading();
        setState(() {
          formId = data['form']['id'];
        });
        refreshToken(data['token']);
        print("new token is ${data['token']}");
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
    }
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

  void goToBack() {
    Navigator.of(context).pop();
  }

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  void goToNextPage() async {
    final result = await Navigator.pushNamed(
        context, '/yangon/residential_power/rp_form04_info',
        arguments: {'form_id': formId});
    setState(() {
      formId = (result ?? 0) as int;
    });
    print('money form id is $formId');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
  
}