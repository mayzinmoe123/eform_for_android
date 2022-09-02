import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../../utils/helper/num_translate.dart';

class TForm03Money extends StatefulWidget {
  const TForm03Money({Key? key}) : super(key: key);

  @override
  State<TForm03Money> createState() => _TForm03MoneyState();
}

class _TForm03MoneyState extends State<TForm03Money> {
  int selectedValue = 0;
  bool selectedValueError = false;
  int? formId;
  bool isLoading = true;
  bool edit = false;
  List fees = [];

  @override
  void initState() {
    super.initState();
    getMeterCost();
  }

  void getMeterCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var apiPath = prefs.getString('api_path');
    var url = Uri.parse('${apiPath}api/ygn_t_money');
    try {
      var response = await http
          .post(url, body: {'token': token, 'form_id': formId.toString()});
      Map data = jsonDecode(response.body);
      if (data['success']) {
        stopLoading();
        refreshToken(data['token']);
        setState(() {
          fees = data['fees'];
        });
        print('fees $fees');
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

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
    print('info form_id is $formId');
    if (data['edit'] != null) {
      setState(() {
        edit = data['edit'];
        selectedValue = data['pole_type'];
      });
    }
    return WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body: isLoading ? loading() : body(context),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
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

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        child: Column(
          children: [
            Card(
                child: Column(
              children: [
                Text(
                  "တိုင်အမျိုးအစား",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                poles(),
              ],
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildCells(28),
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

  Widget poles() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                  // Visual Density passed here
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  dense: true,
                  value: 1,
                  groupValue: selectedValue,
                  title: Text("တစ်တိုင်"),
                  onChanged: ((value) {
                    setState(() {
                      selectedValue = 1;
                    });
                  })),
            ),
            Expanded(
              child: RadioListTile(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  dense: true,
                  value: 2,
                  groupValue: selectedValue,
                  title: Text("နှစ်တိုင်"),
                  onChanged: ((value) {
                    setState(() {
                      selectedValue = 2;
                    });
                  })),
            ),
            Expanded(
              child: RadioListTile(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  dense: true,
                  value: 3,
                  groupValue: selectedValue,
                  title: Text("တိုင်များ"),
                  onChanged: ((value) {
                    setState(() {
                      selectedValue = 3;
                    });
                  })),
            ),
          ],
        ),
        selectedValueError
            ? Text(
                'တိုင်အမျိုးအစားရွေးချယ်ပေးပါ။',
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
            : SizedBox()
      ],
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
            style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget meterCostsWidget() {
    return Column(
        children: fees.map((fee) {
      return _getDetailData(
          fee["type"].toString(),
          fee["name"],
          fee["assign_fee"],
          fee["deposit_fee"],
          fee["string_fee"],
          fee["service_fee"],
          fee["registration_fee"],
          fee["total"]);
    }).toList());
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
                      "စုစုပေါင်း"),
                  meterCostsWidget(),
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
                      "စုစုပေါင်း"),
                ],
              ),
            ));
  }

  Widget _getDetailData(subType, d1, d2, d3, d4, d5, d6, d7) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
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
          _makeChooseBtn(subType),
        ],
      ),
    );
  }

  Widget _getDetailDataHeader(d1, d2, d3, d4, d5, d6, d7) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
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
        ],
      ),
    );
  }

  Widget _getDetailDataHeader2(d1, d2) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
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
          if (selectedValue > 0) {
            meterTypeSave(subType);
          } else {
            setState(() {
              selectedValueError = true;
            });
          }
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
        'apply_division': '1', // ygn=1, mdy=3, other=2
        'apply_tsf_type': '1', // residential = 1, commercial = 2
        'pole_type': selectedValue.toString(),
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
      final result = await Navigator.pushNamed(context, 'ygn_t_form04_info',
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
