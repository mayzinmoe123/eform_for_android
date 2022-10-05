import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CForm01RulesMdy extends StatefulWidget {
  const CForm01RulesMdy({Key? key}) : super(key: key);

  @override
  State<CForm01RulesMdy> createState() => _CForm01RulesMdyState();
}

class _CForm01RulesMdyState extends State<CForm01RulesMdy> {
  var checkedValue = false;
  bool isLoading = true;
  List<String> rules = [
    "မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားရာတွင် ဌာနမှပူးတွဲတင်ပြရန် သက်မှတ်ထားသော စာရွက်စာတမ်းများအား ထင်ရှားပြတ်သားစွာ ဓါတ်ပုံရိုက်ယူ၍သော်လည်ကောင်း၊ Scan ဖတ်၍သော်လည်ကောင်း ပူးတွဲတင်ပြပေးရမည်။",
    "ပူးတွဲပါစာရွက်စာတမ်းများ မပြည့်စုံခြင်း၊ ထင်ရှားမှု၊ ပြတ်သားမှုမရှိပါက လျှောက်လွှာအား ထည့်သွင်းစဉ်းစားမည် မဟုတ်ပါ။",
    "တရားဝင်နေထိုင်ကြောင်းထောက်ခံစာနှင့် ကျူးကျော်မဟုတ်ကြောင်းထောက်ခံစာများသည် (၁ လ) အတွင်းရယူထားသော ထောက်ခံစာများဖြစ်ရမည်။",
    "မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားသူ၏ အိမ်အမှတ် / တိုက်အမှတ် / တိုက်ခန်းအမှတ်၊ လမ်းအမည်၊ လမ်းသွယ်အမည်၊ ရပ်ကွပ်အမည် နှင့် မြို့နယ်/ကျေးရွာ အမည်တို့ကို တိကျမှန်ကန်စွာ ဖြည့်သွင်းပေးရမည်။",
    "ပူးတွဲပါစာရွက်စာတမ်းများအား အင်ဂျင်နီယာဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့် အချိန်တွင် စစ်ဆေးသွားမည် ဖြစ်ပြီး စာရွက်စာတန်းများအား အတုပြုလုပ်ခြင်း၊ ပြင်ဆင်ခြင်းများ တွေ့ရှိပါက တည်ဆဲဥပဒေအရ ထိရောက်စွာ အရေးယူခြင်းခံရမည် ဖြစ်ပါသည်။",
    "ကန်ထရိုက်တိုက်မီတာလျှောက်ထားရာတွင် ဝန်အားနိုင်နင်းမှုမရှိပါက ကိုယ်ပိုင်ထရန်စဖေါ်မာ တည်ဆောက်ရန်လိုအပ်ပြီး၊ မီတာတစ်လုံးစီအတွက် မီတာကြေး (၉၀,၀၀၀ ကျပ်) ပေးဆောင်ရမည် ဖြစ်ပါသည်။",
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
    return  isLoading ? loading() :  WillPopScope(
      child: Scaffold(
        appBar: applicationBar(context),
        body:  body(),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
    );
  }

  AppBar applicationBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        "စည်းမျဥ်းစည်းကမ်းများ",
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

  Widget body() {
    return ListView(
      // child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Column(
          children: rules.map((title) => _getRulesTxt(title)).toList(),
        ),
        _getCheckBox(
            "အထက်ပါ စည်းမျဥ်းစည်းကမ်းများကို နားလည်သိရှိပါက လိုက်နာရန် အမှန်ခြစ်ပါ။"),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton(),
            SizedBox(width: 5),
            saveButton(context),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget cancelButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: Colors.grey[600],
      ),
      child: Text(
        "မပြုလုပ်ပါ",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (checkedValue == true) {
          goToNextPage(context);
        } else {
          showSnackBar(context,
              "စည်းမျဥ်းစည်းကမ်းများကို လိုက်နာမည်ဖြစ်ကြောင်း အမှန်ခြစ်ပါ။");
        }
      },
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: checkedValue ? Colors.blue : Colors.grey,
      ),
      child: Text(
        "လုပ်ဆောင်မည်",
        style: TextStyle(fontSize: 12),
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
          size: 5,
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
    Navigator.pushNamed(context, 'mdy_c_form02_promise');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
