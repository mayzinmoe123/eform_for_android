import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Rp03Money extends StatefulWidget {
  const Rp03Money({Key? key}) : super(key: key);

  @override
  State<Rp03Money> createState() => _Rp03MoneyState();
}

class _Rp03MoneyState extends State<Rp03Money> {
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
    return Scaffold(
      appBar: applicationBar(),
      body: isLoading ? loading() : body(),
    );
  }

  AppBar applicationBar() {
    return AppBar(
      centerTitle: true,
      title: Text("ကောက်ခံမည့်နှုန်းများ", style: TextStyle(fontSize: 18.0)),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          goToBack();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            goToHomePage(context);
          },
          icon: Icon(
            Icons.home,
            size: 18.0,
          ),
        ),
      ],
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

  Widget body() {
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
                _getTableHeader("အကြောင်းအရာများ", "၁၀ ကီလိုဝပ်", "၂၀ ကီလိုဝပ်",
                    "၃၀ ကီလိုဝပ်"),
                getTableBodyDetail(
                    "မီတာသတ်မှတ်ကြေး", "၈၀၀,၀၀၀", "၁,၀၀၀,၀၀၀", "၁,၂၀၀,၀၀၀"),
                getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀", "၄,၀၀၀", "၄,၀၀၀"),
                getTableBodyDetail(
                    "လိုင်းကြိုး (ဆက်သွယ်ခ)", "၆,၀၀၀", "၆,၀၀၀", "၆,၀၀၀"),
                getTableBodyDetail(
                    "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၂,၀၀၀", "၂,၀၀၀", "၂,၀၀၀"),
                getTableBodyDetail(
                    "composit box", "၄၀,၀၀၀", "၄၀,၀၀၀", "၄၀,၀၀၀"),
                getTableBodyDetail(
                    "စုစုပေါင်း", "၈၅၂,၀၀၀", "၁,၀၅၂,၀၀၀", "၁,၂၅၂,၀၀၀"),
                _getChooseBtn(),
                // TableRow(children: [
                //   ElevatedButton(onPressed: () {}, child: Text("ရွေးချယ်မည်")),
                // ])
              ],
            ),
            SizedBox(height: 10),
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
      _makeChooseBtn(1),
      _makeChooseBtn(2),
      _makeChooseBtn(3),
    ]);
  }

  Widget _makeChooseBtn(int type) {
    return Container(
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        onPressed: () {
          startLoading();
          meterTypeSave(type);
        },
        // style: OutlinedBorder(),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void meterTypeSave(int type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiPath = pref.getString("api_path").toString();
    String token = pref.getString("token").toString();
    try {
      print("old token is $token");
      var url = Uri.parse("${apiPath}api/meter_type");
      var response = await http.post(url, body: {
        'token': token,
        'apply_type': '2', // residential power meter
        'apply_division': '2', // ygn=1, mdy=3, other=2
        'apply_sub_type': type.toString(),
        'form_id': formId != null ? formId.toString() : '',
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
      final result = await Navigator.pushNamed(context, 'other_rp04_info',
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
