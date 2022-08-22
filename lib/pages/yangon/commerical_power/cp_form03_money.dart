import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form04_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CpForm03Money extends StatefulWidget {
  const CpForm03Money({Key? key}) : super(key: key);

  @override
  State<CpForm03Money> createState() => _CpForm03MoneyState();
}

class _CpForm03MoneyState extends State<CpForm03Money> {
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
                border: TableBorder.all(
                  color: Colors.black,
                ),
                children: [
                  _getTableHeader(
                      "အကြောင်းအရာများ", "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)","ကောက်ခံရမည့်နှုန်းထား (ကျပ်)","ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                        _getTableHeader(
                      "အကြောင်းအရာများ", "၁၀ ကီလိုဝပ်","၂၀ ကီလိုဝပ်","၃၀ ကီလိုဝပ်"),
                  getTableBodyDetail("မီတာသတ်မှတ်ကြေး", "၈၀၀,၀၀၀","၁,၀၀၀,၀၀၀","၁,၂၀၀,၀၀၀"),
                  getTableBodyDetail("အာမခံစဘော်ငွေ", "၈၂,၅၀၀","၁၅၇,၅၀၀","၂၃၂,၅၀၀"),
                  getTableBodyDetail("လိုင်းကြိုး (ဆက်သွယ်ခ)", "၈,၀၀၀","၈,၀၀၀","၈,၀၀၀"),
                  getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၂၀,၀၀၀", "၂၀,၀၀၀", "၂၀,၀၀၀"),
                  getTableBodyDetail("composit box", "၃၄,၀၀၀", "၃၄,၀၀၀", "၃၄,၀၀၀"),
                  getTableBodyDetail("စုစုပေါင်း", "၉၄၄,၅၀၀","၁,၂၁၉,၅၀၀","၁,၄၉၄,၅၀၀"),
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

  TableRow _getTableHeader(d1, d2,d3,d4) {
    return TableRow(children: [
      _getTableHeaderDetail(d1),
      _getTableHeaderDetail(d2),
      _getTableHeaderDetail(d3),
      _getTableHeaderDetail(d4),
    ]);
  }

  Container _getTableHeaderDetail(data) {
    return Container(
      height: 70,
      child: Center(
          child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,
      )),
    );
  }

  Container _getTableBody(name) {
    return Container(
      height: 70,
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
      _getTableBody(d1),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CpForm04Info()));
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
        context, '/yangon/commerical_power/cp_form04_info',
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