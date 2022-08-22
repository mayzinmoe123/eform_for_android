import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form04_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CForm03MeterType extends StatefulWidget {
  const CForm03MeterType({Key? key}) : super(key: key);

  @override
  State<CForm03MeterType> createState() => _CForm03MeterTypeState();
}

class _CForm03MeterTypeState extends State<CForm03MeterType> {
  
  final TextEditingController _apartmentCount = TextEditingController();
  final TextEditingController _floorCount = TextEditingController();
  TextEditingController valueTxt = TextEditingController();
  
  var checkedWaterValue = false;
  var checkedElevatorValue = false;

  int? formId;
  bool isLoading = false;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                _getTextHeader(
                    "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                    Colors.red),
                _getForm("အခန်းတွဲ ***", null, _apartmentCount),
                _getForm("အထပ် ***", null, _floorCount),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _getTextHeader(
                            "ပါဝါမီတာ အရေအတွက်", null, FontWeight.bold, 17.0),
                        _getForm("10 KW"),
                        _getForm("20 KW"),
                        _getForm("30 KW"),
                        _getTextHeader(
                            "ပါဝါမီတာ ထည့်သွင်းလျှောက်ထားလိုလျှင် မိမိလျှောက်ထားလိုသော မီတာအမျိုးအစားတွင် အရေအတွက် ထည့်သွင်းပေးပါရန်",
                            Colors.red),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextFormField(
                    
                    enabled: false, 
                    controller: valueTxt,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: "အိမ်သုံးမီတာ အရေအတွက်",
                    ),
                  ),
                ),
                Card(child: Column(
                  children: [
                    _getWaterCheckBox("ရေစက်မီတာ အသုံးပြုမည်",),
                      _getElevatorCheckBox("ဓါတ်လှေကားမီတာ အသုံးပြုမည်",),
                      SizedBox(height: 10,),
                 _getTextHeader(
                            "ရေစက် / ဓါတ်လှေကား ) မီတာ အသုံးပြုလိုလျှင် အမှန်ခြစ်ပေးပါရန်၊ မီတာအမျိုးအစား(KW)နှင့် အရေအတွက်ကို သက်ဆိုင်ရာမြိုနယ် လျှပ်စစ်အင်ဂျင်နီယာရုံးမှ သတ်မှတ်ပေးသွားမည် ဖြစ်ပါသည်။",
                            Colors.red),
                            SizedBox(height: 15,),
                  ],
                )),
                SizedBox(height: 15,),
                 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    // style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    //
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: Colors.grey),
                    child: Text(
                      "မပြုလုပ်ပါ",
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                  
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CForm04Info()));
                      ;
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text(
                      "လုပ်ဆောင်မည်",
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(height: 20,),

              ],
            ),
             SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForm(name, [hintTxt, value]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: value,
        onChanged: (value){
           String form1 = _apartmentCount.text;
           String form2 = _floorCount.text;
          if(form1 != "" && form2 != ""){
            int valueTxtInt =  int.parse(_apartmentCount.text) * int.parse(_floorCount.text);
            valueTxt.text= valueTxtInt.toString();
          }
        },
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
          
        ),
      ),
    );
  }

  Widget _getTextHeader(txt, [color, weight, size]) {
    return Text(
      txt,
      style: TextStyle(
          color: color,
          fontFamily: "Pyidaungsu",
          fontWeight: weight,
          fontSize: size ?? size),  
      textAlign: TextAlign.center,
    );
  }
  
  Widget _getWaterCheckBox(name) {
    return CheckboxListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 13, ),
      ),
      value: checkedWaterValue,
      onChanged: (newValue) {
        setState(() {
          checkedWaterValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  Widget _getElevatorCheckBox(name) {
    return CheckboxListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 13, ),
      ),
      value: checkedElevatorValue,
      onChanged: (newValue) {
        setState(() {
          checkedElevatorValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
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
        context, '/yangon/contractor/c_form04_info',
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
