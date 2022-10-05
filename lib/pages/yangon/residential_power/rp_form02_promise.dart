import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RpForm02Promise extends StatefulWidget {
  const RpForm02Promise({Key? key}) : super(key: key);

  @override
  State<RpForm02Promise> createState() => _RpForm02PromiseState();
}

class _RpForm02PromiseState extends State<RpForm02Promise> {
  var checkedValue = false;
  bool isLoading = true;
  List<String> rules = [
    "လျှောက်ထားသူသည် ယခုအိမ်သုံးပါဝါမီတာ လျှောက်ထားခြင်းအတွက် မည်သူကိုမျှ လာဘ်ငွေ၊ တံစိုးလက်ဆောင် တစ်စုံတစ်ရာ ပေးရခြင်းမရှိပါ။",
    "သတ်မှတ်ကြေးငွေများကို တစ်လုံးတစ်ခဲတည်း ပေးသွင်းသွားမည်ဖြစ်ပြီး ဓာတ်အားခများကိုလည်း လစဉ်ပုံမှန်ပေးချေသွားပါမည်။",
    "တည်ဆဲဥပဒေ၊ စည်းမျဉ်းများနှင့် အခါအားလျှော်စွာ ထုတ်ပြန်သောအမိန့်နှင့် ညွှန်ကြားချက်များကို တိကျစွာလိုက်နာ ဆောင်ရွက်သွားပါမည်ဟု ဝန်ခံကတိပြုပါသည်။",
    "လက်ရှိတပ်ဆင်ထားသော အိမ်သုံးမီတာအား ဌာနသို့ ပြည်လည်အပ်နှံ၍ Test Lab ဌာနသို့ပေးပို့စစ်ဆေးပြီး Test Lab Result အရ လျော်ကြေး၊ ဒဏ်ကြေး၊ နစ်နာကြေး ပေးဆောင်ရမည်ဆိုပါက ပေးဆောင်မည်ဖြစ်ပါကြောင်း ဝန်ခံကတိပြုပါသည်။"
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

  void goToBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(context),
        body:  body(context),
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
        context, '/', (Route<dynamic> route) => false);
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

  void goToNextPage(BuildContext context) {
    Navigator.pushNamed(context, '/yangon/residential_power/rp_form03_money');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
