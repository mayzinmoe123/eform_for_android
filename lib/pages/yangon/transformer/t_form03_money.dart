import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form04_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../../utils/helper/num_translate.dart';
// import 'package:flutter_application_1/utils/helper/num_translate.dart';

class TForm03Money extends StatefulWidget {
  const TForm03Money({Key? key}) : super(key: key);

  @override
  State<TForm03Money> createState() => _TForm03MoneyState();
}


class _TForm03MoneyState extends State<TForm03Money> {
  int selectedValue = 0; 
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
              Card(child: Column(
                children: [
                  Text("တိုင်အမျိုးအစား",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                   Row(
                children: [
                 Expanded(
                   child: RadioListTile(
          // Visual Density passed here
          visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 0, groupValue: selectedValue,title: Text("တစ်တိုင်"), onChanged: ((value) {
                     setState(() {
                       selectedValue =0;
                     });
                   })),
                 ),
                  Expanded(
                   child: RadioListTile(visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 1, groupValue: selectedValue,title: Text("နှစ်တိုင်"), onChanged: ((value) {
                     setState(() {
                       selectedValue =1;
                     });
                   })),
                 ),
                  Expanded(
                   child: RadioListTile(visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 2, groupValue: selectedValue,title: Text("တိုင်များ"), onChanged: ((value) {
                     setState(() {
                       selectedValue =2;
                     });
                   })),
                 ),
                ],
              ),
               
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
        ));
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
        child: Text(replaceFarsiNumber("${index == 0 || index == -1 || index == 1 ? '' : (index++)-1}"),
            style: TextStyle(fontSize: 16)),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
        count,
        (index) => SingleChildScrollView(
              child: Column(
                children: [
                  _getDetailDataHeader2("အကြောင်းအရာများ", "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                   _getDetailDataHeader("အမျိုးအစား (ကေဗွီအေ)", "မီတာသတ်မှတ်ကြေး", "အာမခံစဘော်ငွေ", "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                      "မီးဆက်ခ", "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "စုစုပေါင်း"),
                  _getDetailData("၅၀", "၁,၈၀၀,၀၀၀/-", "၃၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၂,၁၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀", "၂,၁၀၀,၀၀၀/-", "၆၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၂,၇၃၅,၅၀၀/-"),
                  _getDetailData("၁၅၀", "၂,၄၀၀,၀၀၀/-", "၉၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၃,၃၃၅,၅၀၀/-"),
                  _getDetailData("၁၆၀", "၁,၈၀၀,၀၀၀/-", "၉၆၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၃,၃၉၅,၅၀၀/-"),
                  _getDetailData("၂၀၀", "၂,၇၀၀,၀၀၀/-", "၁,၂၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၃,၉၃၅,၅၀၀/-"),
                  _getDetailData("၂၅၀", "၃,၀၀၀,၀၀၀/-", "၁,၅၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၄,၅၃၅,၅၀၀/-"),
                  _getDetailData("၃၀၀", "၃,၃၀၀,၀၀၀/-", "၁,၈၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၅,၁၃၅,၅၀၀/-"),
                  _getDetailData("၃၁၅", "၃,၃၀၀,၀၀၀/-", "၁,၈၉၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၅,၂၂၅,၅၀၀/-"),
                  _getDetailData("၄၀၀", "၃,၉၀၀,၀၀၀/-", "၂,၄၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၆,၃၃၅,၅၀၀/-"),
                  _getDetailData("၄၅၀", "၄,၂၀၀,၀၀၀/-", "၂,၇၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၆,၉၃၅,၅၀၀/-"),
                  _getDetailData("၅၀၀", "၄,၅၀၀,၀၀၀/-", "၃,၀၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၇,၅၃၅,၅၀၀/-"),
                  _getDetailData("၇၀၀", "၅,၈၀၀,၀၀၀/-", "၄,၂၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၇၅၀", "၆,၃၀၀,၀၀၀/-", "၄,၅၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၀,၈၃၅,၅၀၀/-"),
                  _getDetailData("၉၀၀", "၆,၈၀၀,၀၀၀/-	", "၅,၄၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၂,၂၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀၀", "၇,၈၀၀,၀၀၀/-", "၆,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၃,၈၃၅,၅၀၀/-"),
                  _getDetailData("၁၁၀၀", "၈,၃၀၀,၀၀၀/-", "၆,၆၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၄,၉၃၅,၅၀၀/-"),
                  _getDetailData("၁၂၅၀", "၉,၃၀၀,၀၀၀/-", "၇,၅၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၆,၈၃၅,၅၀၀/-"),
                  _getDetailData("၂၀၀၀", "၁၈,၀၀၀,၀၀၀/-", "၁၂,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၃၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၂၅၀၀", "၂၁,၀၀၀,၀၀၀/-", "၁၅,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၂၃၆,၀၃၅,၅၀၀/-"),
                  _getDetailData("၃၀၀၀", "၂၅,၀၀၀,၀၀၀/-", "၁၈,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၄၃,၀၃၅,၅၀၀/-"),
                  _getDetailData("၅၀၀၀", "၅၀,၀၀၀,၀၀၀/-", "၃၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၈၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀၀၀", "၁၀၀,၀၀၀,၀၀၀/-", "၆၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၁၆၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၁၅၀၀၀", "၁၅၀,၀၀၀,၀၀၀/-", "၉၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၂၄၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၂၀၀၀၀", "၂၀၀,၀၀၀,၀၀၀/-", "၁၂၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၃၂၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၂၅၀၀၀", "၂၅၀,၀၀၀,၀၀၀/-", "၁၅၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၄၀၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၃၀၀၀၀", "၃၀၀,၀၀၀,၀၀၀/-", "၁၈၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-", "၄၈၀,၀၃၅,၅၀၀/-"),
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
                  _getDetailDataHeader2("အကြောင်းအရာများ", "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                  _getDetailData("အမျိုးအစား (ကေဗွီအေ)", "မီတာသတ်မှတ်ကြေး", "အာမခံစဘော်ငွေ", "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                      "မီးဆက်ခ", "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "စုစုပေါင်း"),
                ],
              ),
            ));
  }

   

  Widget _getDetailData(d1, d2, d3, d4, d5, d6, d7) {
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
          _makeChooseBtn(),
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
       decoration: BoxDecoration(
    border: Border.all(color: Colors.black38)
  ),
      child: Text(
        name,
        style: TextStyle(fontSize: 16),
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
        style: TextStyle(fontSize: 16),
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

  TableRow _getChooseBtn() {
    return TableRow(children: [
      Text(""),
      _makeChooseBtn(),
      _makeChooseBtn(),
      _makeChooseBtn(),
    ]);
  }

  Widget _makeChooseBtn() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TForm04Info()));
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
        context, '/yangon/transformer/t_form04_info',
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
