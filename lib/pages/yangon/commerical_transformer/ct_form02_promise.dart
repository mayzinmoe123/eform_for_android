import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CtForm02Promise extends StatefulWidget {
  const CtForm02Promise({Key? key}) : super(key: key);

  @override
  State<CtForm02Promise> createState() => _CtForm02PromiseState();
}

class _CtForm02PromiseState extends State<CtForm02Promise> {
  var checkedValue = false;
  // bool isLoading = true;
  bool isLoading = false;
  List<String> rules = [
    "လျှောက်ထားသူသည် ယခုထရန်စဖေါ်မာ လျှောက်ထားခြင်းအတွက် မည်သူကိုမျှ လာဘ်ငွေ၊ တံစိုးလက်ဆောင် တစ်စုံတစ်ရာ ပေးရခြင်းမရှိပါ။",
    "ထရန်စဖေါ်မာတည်ဆောက်ခွင့် ရရှိပါက သက်မှတ်ထားသော စံချိန်စံညွှန်းများနှင့်အညီ တည်ဆောက်သွားပါမည်။",
    "သတ်မှတ်ကြေးငွေများကို တစ်လုံးတစ်ခဲတည်း ပေးသွင်းသွားမည်ဖြစ်ပြီး ဓာတ်အားခများကိုလည်း လစဉ်ပုံမှန်ပေးချေသွားပါမည်။",
    "တည်ဆဲဥပဒေ၊ စည်းမျဉ်းများနှင့် အခါအားလျှော်စွာ ထုတ်ပြန်သောအမိန့်နှင့် ညွှန်ကြားချက်များကို တိကျစွာလိုက်နာ ဆောင်ရွက်သွားပါမည်ဟု ဝန်ခံကတိပြုပါသည်။",
    "လျှောက်ထားသူသည် ဓာတ်အားသုံးစွဲခွင့် ရရှိပြီးနောက်ပိုင်းတွင် လိုအပ်လာပါက ဌာန၏ သတ်မှတ်ထားသော အခြားနေရာများသို့ ဓါတ်အားလိုင်းချိတ်ဆက်နိုင်စေရန် ခွင့်ပြုပေးရမည်ဖြစ်ပြီး ကန့်ကွက်ရန် မရှိကြောင်း ဝန်ခံကတိပြုပါသည်။",
    "မိမိပိုင် မြေပေါ်တွင်သာ တပ်ဆင်မည်ဖြစ်ကြောင်းဝန်ခံကတိပြုပါသည်။",
    "စည်ပင်မြေပေါ်တွင်တပ်ဆင်မည်ဆိုပါက ရန်ကုန်မြို့တော်သာယာရေးကော်မတီ၏ ခွင့်ပြုချက်ရယူထားပါမည်။",
    "ထရန်ဖော်မာအား ကာယံကာရှင်မှ ထိန်းသိမ်းစောင့်ရှောက်ပြီး ဓါတ်အားလိုင်းအား ရန်ကုန်လျှပ်စစ်ဓါတ်အားပေး ကော်ပိုရေးရှင်းသို့ အပ်နှံပါမည်။",
    "ပါဝါထရန်စဖော်မာလျှောက်ထားရာတွင် လျှောက်ထားသူမှ လျှပ်စစ်ဓာတ်အား မလုံလောက်ပါက ကိုယ်ပိုင်မီးစက်ဖြင့် အသုံးပြုပါမည်။",
  ];

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
      if (data['success']) {
        stopLoading();
        refreshToken(data['token']);
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

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: applicationBar(context),
        body: isLoading ? loading() : body(context),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
    );
  }

  AppBar applicationBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "ဝန်ခံကတိပြုချက်",
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
      child: Column(
        children: [
          SizedBox(height: 10),
          Column(
            children: rules.map((value) => _getRulesTxt(value)).toList(),
          ),
          _getCheckBox(
              "အထက်ပါ စည်းမျဥ်းစည်းကမ်းများကို ဝန်ခံကတိပြုရန် အမှန်ခြစ်ပါ။"),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cancelButton(),
              SizedBox(width: 5),
              saveButton(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _getRulesTxt(title) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ListTile(
        dense: true,
        minLeadingWidth: 10.0,
        leading: Icon(
          Icons.circle,
          size: 5.0,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 13),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _getCheckBox(name) {
    return CheckboxListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 13, color: Colors.redAccent),
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  void goToBack() {
    Navigator.of(context).pop();
  }

  Widget cancelButton() {
    return ElevatedButton(
        onPressed: () {
          goToBack();
        },
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(), primary: Colors.grey[600]),
        child: Text(
          "မပြုလုပ်ပါ",
          style: TextStyle(fontSize: 12),
        ));
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (checkedValue == true) {
            goToNextPage(context);
          } else {
            showSnackBar(context,
                "စည်းမျဥ်းစည်းကမ်းများကို ဝန်ခံကတိပြုမည်ဖြစ်ကြောင်း အမှန်ခြစ်ပါ။");
          }
        },
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            primary: checkedValue ? Colors.blue : Colors.grey),
        child: Text(
          "လုပ်ဆောင်မည်",
          style: TextStyle(fontSize: 12),
        ));
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(fontFamily: "Pyidaungsu"),
      ),
      action: SnackBarAction(
        label: "ပိတ်မည်",
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
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

  void goToNextPage(BuildContext context) {
    Navigator.pushNamed(context, 'ygn_ct_form03_money_type');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
