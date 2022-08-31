import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../../utils/helper/num_translate.dart';

class TForm03MoneyMdy extends StatefulWidget {
  const TForm03MoneyMdy({Key? key}) : super(key: key);

  @override
  State<TForm03MoneyMdy> createState() => _TForm03MoneyMdyState();
}

class _TForm03MoneyMdyState extends State<TForm03MoneyMdy> {
  int selectedValue = 0;
  bool selectedValueError = false;
  int? formId;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: applicationBar(), body: body());
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

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildCells(22),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildRows(1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 60.0,
        height: 80.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Text(
            replaceFarsiNumber(
                "${index == 0 || index == -1 || index == 1 ? '' : (index++) - 1}"),
            style: TextStyle(fontSize: 14)),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
        count,
        (index) => SingleChildScrollView(
              child: Column(
                children: [
                  _getDetailDataHeader2("အကြောင်းအရာများ",
                      "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                  _getDetailDataHeader(
                    "အမျိုးအစား (ကေဗွီအေ)",
                    "မီတာသတ်မှတ်ကြေး",
                    "အာမခံစဘော်ငွေ",
                    "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                    "မီးဆက်ခ",
                    "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး",
                    "တည်ဆောက်စရိတ်",
                    "စုစုပေါင်း",
                  ),
                  _getDetailData(
                      "1",
                      "၅၀",
                      "၁,၈၀၀,၀၀၀/-",
                      "၃၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၂,၁၃၅,၅၀၀/-"),
                  _getDetailData(
                      "2",
                      "၁၀၀",
                      "၂,၁၀၀,၀၀၀/-",
                      "၆၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၂,၇၃၅,၅၀၀/-"),
                  _getDetailData(
                      "23",
                      "၁၆၀",
                      "၂,၄၀၀,၀၀၀/-",
                      "၉၆၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၃,၇၉၅,၅၀၀/-"),
                  _getDetailData(
                      "5",
                      "၂၀၀",
                      "၂,၇၀၀,၀၀၀/-",
                      "၁,၂၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၄,၃၃၅,၅၀၀/-"),
                  _getDetailData(
                      "6",
                      "၂၅၀",
                      "၃,၀၀၀,၀၀၀/-",
                      "၁,၅၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၄,၉၃၅,၅၀၀/-"),
                  _getDetailData(
                      "8",
                      "၃၁၅",
                      "၃,၃၀၀,၀၀၀/-",
                      "၁,၈၉၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၅,၆၂၅,၅၀၀/-"),
                  _getDetailData(
                      "9",
                      "၄၀၀",
                      "၃,၉၀၀,၀၀၀/-",
                      "၂,၄၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၄၀၀,၀၀၀/-",
                      "၆,၇၃၅,၅၀၀/-"),
                  _getDetailData(
                      "11",
                      "၅၀၀",
                      "၄,၅၀၀,၀၀၀/-",
                      "၃,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၈,၀၃၅,၅၀၀/-"),
                  _getDetailData(
                      "12",
                      "၆၃၀",
                      "၅,၈၀၀,၀၀၀/-",
                      "၃,၇၈၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၁၀,၁၁၅,၅၀၀/-"),
                  _getDetailData(
                      "13",
                      "၇၅၀",
                      "၆,၃၀၀,၀၀၀/-",
                      "၄,၅၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၁၁,၃၃၅,၅၀၀/-"),
                  _getDetailData(
                      "14",
                      "၈၀၀",
                      "၆,၈၀၀,၀၀၀/-	",
                      "၄,၈၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၁၂,၁၃၅,၅၀၀/-"),
                  _getDetailData(
                      "15",
                      "၁၀၀၀",
                      "၇,၈၀၀,၀၀၀/-",
                      "၆,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၁၄,၃၃၅,၅၀၀/-"),
                  _getDetailData(
                      "17",
                      "၁၂၅၀",
                      "၉,၃၀၀,၀၀၀/-",
                      "၇,၅၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၁,၀၀၀,၀၀၀/-",
                      "၁၇,၈၃၅,၅၀၀/-"),
                  _getDetailData(
                      "18",
                      "၁၅၀၀",
                      "၁၈,၀၀၀,၀၀၀/-",
                      "၉,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၁,၀၀၀,၀၀၀/-",
                      "၂၈,၀၃၅,၅၀၀/-"),
                  _getDetailData(
                      "20",
                      "၃၀၀၀",
                      "၂၅,၀၀၀,၀၀၀/-",
                      "၁၈,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၁,၂၀၀,၀၀၀/-",
                      "၄၄,၂၃၅,၅၀၀/-"),
                  _getDetailData(
                      "21",
                      "၅၀၀၀",
                      "၅၀,၀၀၀,၀၀၀/-",
                      "၃၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၁,၆၀၀,၀၀၀/-",
                      "၈၁,၆၃၅,၅၀၀/-"),
                  _getDetailData(
                      "22",
                      "၁၀၀၀၀",
                      "၁၀၀,၀၀၀,၀၀၀/-",
                      "၆၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၁,၆၀၀,၀၀၀/-",
                      "၁၆၁,၆၃၅,၅၀၀/-"),
                  _getDetailData(
                      "24",
                      "၂၀၀၀၀",
                      "၂၀၀,၀၀၀,၀၀၀/-",
                      "၁၂၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၂၅,၀၀၀,၀၀၀/-",
                      "၃၄၅,၀၃၅,၅၀၀/-"),
                  _getDetailData(
                      "25",
                      "၂၅၀၀၀",
                      "၂၅၀,၀၀၀,၀၀၀/-",
                      "၁၅၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၃၀,၀၀၀,၀၀၀/-",
                      "၄၃၀,၀၃၅,၅၀၀/-"),
                  _getDetailData(
                      "26",
                      "၃၀၀၀၀",
                      "၃၀၀,၀၀၀,၀၀၀/-",
                      "၁၈၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-",
                      "၂,၀၀၀/-",
                      "၂၀,၀၀၀/-",
                      "၅၀၀,၀၀၀/-",
                      "၄၈၀,၀၃၅,၅၀၀/-"),
                ],
              ),
            ));
  }

  List<Widget> _buildHeaderRows(int count) {
    return List.generate(
        count,
        (index) => SingleChildScrollView(
              child: Column(
                children: [
                  _getDetailDataHeader2("အကြောင်းအရာများ",
                      "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                  _getDetailData(
                    "",
                    "အမျိုးအစား (ကေဗွီအေ)",
                    "မီတာသတ်မှတ်ကြေး",
                    "အာမခံစဘော်ငွေ",
                    "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                    "မီးဆက်ခ",
                    "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး",
                    "တည်ဆောက်စရိတ်",
                    "စုစုပေါင်း",
                  ),
                ],
              ),
            ));
  }

  Widget _getDetailData(String subtype, String d1, String d2, String d3,
      String d4, String d5, String d6, String d7, String d8) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 1070,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableBody(d2),
          _getTableBody(d3),
          _getTableBody(d4),
          _getTableBody(d5),
          _getTableBody(d6),
          _getTableBody(d7),
          _getTableBody(d8),
          _makeChooseBtn(subtype),
        ],
      ),
    );
  }

  Widget _getDetailDataHeader(d1, d2, d3, d4, d5, d6, d7, d8) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 1070,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableBody(d2),
          _getTableBody(d3),
          _getTableBody(d4),
          _getTableBody(d5),
          _getTableBody(d6),
          _getTableBody(d7),
          _getTableBody(d8),
        ],
      ),
    );
  }

  Widget _getDetailDataHeader2(d1, d2) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 1070,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableHeader(d2),
        ],
      ),
    );
  }

  Container _getTableHeader(name) {
    return Container(
      // height: 70,
      width: 800,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
      child: Text(
        name,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _getTableBody(name) {
    return Container(
      // height: 70,
      width: 120,
      padding: EdgeInsets.all(14),
      child: Text(
        name,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow getTableBodyDetail(d1, d2, d3, d4) {
    return TableRow(children: [
      _getTableBody(d1),
      _getTableBody(d2),
      _getTableBody(d3),
      _getTableBody(d4),
    ]);
  }

  Widget _makeChooseBtn(String subType) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        onPressed: () {
          meterTypeSave(subType);
        },
        // style: OutlinedBorder(),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Text(
          "ရွေးချယ်မည်",
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  void meterTypeSave(String subType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiPath = pref.getString("api_path").toString();
    String token = pref.getString("token").toString();
    try {
      print("old token is $token");
      var url = Uri.parse("${apiPath}api/meter_type_transformer");
      Map bodyData = {
        'token': token,
        'form_id': formId != null ? formId.toString() : '',
        'apply_type': '4', // transformer
        'apply_division': '3', // ygn=1, mdy=3, other=2
        'apply_sub_type': subType.toString(),
      };
      var response = await http.post(url, body: bodyData);
      print('bodyData is $bodyData');
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
        print(data);
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
    final result = await Navigator.pushNamed(context, 'mdy_t_form04_info',
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
