import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TForm01Rules extends StatefulWidget {
  const TForm01Rules({Key? key}) : super(key: key);

  @override
  State<TForm01Rules> createState() => _TForm01RulesState();
}

class _TForm01RulesState extends State<TForm01Rules> {
  var checkedValue = false;
  bool isLoading = true;
  List<String> rules = [
    "မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားရာတွင် ဌာနမှပူးတွဲတင်ပြရန် သက်မှတ်ထားသော စာရွက်စာတမ်းများအား ထင်ရှားပြတ်သားစွာ ဓါတ်ပုံရိုက်ယူ၍သော်လည်ကောင်း၊ Scan ဖတ်၍သော်လည်ကောင်း ပူးတွဲတင်ပြပေးရမည်။",
    "ပူးတွဲပါစာရွက်စာတမ်းများ မပြည့်စုံခြင်း၊ ထင်ရှားမှု၊ ပြတ်သားမှုမရှိပါက လျှောက်လွှာအား ထည့်သွင်းစဉ်းစားမည် မဟုတ်ပါ။",
    "တရားဝင်နေထိုင်ကြောင်းထောက်ခံစာနှင့် ကျူးကျော်မဟုတ်ကြောင်းထောက်ခံစာများသည် (၁ လ) အတွင်းရယူထားသော ထောက်ခံစာများဖြစ်ရမည်။",
    "မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားသူ၏ အိမ်အမှတ် / တိုက်အမှတ် / တိုက်ခန်းအမှတ်၊ လမ်းအမည်၊ လမ်းသွယ်အမည်၊ ရပ်ကွပ်အမည် နှင့် မြို့နယ်/ကျေးရွာ အမည်တို့ကို တိကျမှန်ကန်စွာ ဖြည့်သွင်းပေးရမည်။",
    "ပူးတွဲပါစာရွက်စာတမ်းများအား အင်ဂျင်နီယာဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့် အချိန်တွင် စစ်ဆေးသွားမည် ဖြစ်ပြီး စာရွက်စာတန်းများအား အတုပြုလုပ်ခြင်း၊ ပြင်ဆင်ခြင်းများ တွေ့ရှိပါက တည်ဆဲဥပဒေအရ ထိရောက်စွာ အရေးယူခြင်းခံရမည် ဖြစ်ပါသည်။",
  ];

  List<String> rules2 = [
    "ထရန်စဖေါ်မာတပ်ဆင်ထားသော နေရာသည် လွယ်ကူစွာ ကြည့်ရှုနိုင်သော ဝန်းခြံအရှေ့မျက်နှာစာ နေရာမျိုးဖြစ်ရမည်။",
    "နည်းပညာ စံချိန်စံညွှန်းနှင့် ကိုက်ညီမှုရှိသော အမျိုးအစားကောင်းမွန်သည့် ထရန်စဖေါ်မာကိုသာ တပ်ဆင်ရမည်။",
    "Protection အတွက် HT Side တွင် Lightning Arrestor, Disconnection Switch, Drop Out Fuse (with respected fuse link), Enclosed Cutout Fuse တပ်ဆင်ရန်နှင့် Lightning Arrestor ကို Transformer ၏ HT Bushing နှင့် အနီးဆုံးနေရာတွင် တပ်ဆင်ရမည်။",
    "ဗို့အားကျဆင်မှုမဖြစ်ပွားစေရန် LT Side တွင်အမျိုးအစားကောင်းမွန်သော Capacitor Bank တပ်ဆင်၍ အမြဲတမ်း အလုပ်လုပ်စေပြီး ချို့ယွင်းပျက်စီးပါက ချက်ချင်းအသစ်တစ်လုံး တပ်ဆင်ရမည်။",
    "L.T Sideတွင် 400V Distribution Panel ( 4P – NFB + (Volt + Ampere) Meter + Pilot Lamp + Voltage Selector Switch ) တပ်ဆင်ရန်နှင့် ထရန်စဖေါ်မာ၏ LT Bushing Cap တပ်ဆင်၍ Seal ခတ်ရမည်။",
    "Earthing System အတွက် သတ်မှတ်ထားသော earth result ရရှိရမည်ဖြစ်ပြီး earth mesh မှ L.A ၊ D.S ၊ DOF, Transformer Body နှင့် Neutral သို့ earth wire တစ်ချောင်းစီဖြင့် သီးသန့်ဆက်သွယ်ရမည်။ လျှပ်စစ်စစ်ဆေးရေးဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့်အချိန်တွင် သတ်မှတ်ထားသော earth result မရရှိခြင်းနှင့် သတ်မှတ်ထားသော ညွှန်ကြားချက်များအတိုင်း လိုက်နာဆောင်ရွက်ခြင်းမရှိပါက ပြန်လည်ပြုပြင်ပေးရမည်။",
    "မြေ/အဆောက်အဉီးဆိုင်ရာ အငြင်းပွားခြင်း၊ ဓာတ်အားသုံးစွဲသည့် လုပ်ငန်းနှင့် ပက်သက်၍ ကန့်ကွက်ခြင်းများ ပေါ်ပေါက်လာပါက ခွင့်ပြုမိန့်ရုပ်သိမ်း၍ ဓာတ်အားဖြတ်တောက်ခြင်း ဆောင်ရွက်သွားရမည်ကို သိရှိလိုက်နာရမည်။",
    "ရုံးမှ ဓာတ်လွှတ်ရန် ခွင့်ပြုမိန့်ရရှိမှသာ ဓာတ်အားလွှတ်၍ မီးသုံးစွဲရမည်။"
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
    return isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(context),
        body: body(),
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
        SizedBox(height: 15),
        getHeaderRulesTxt(
            "ကိုယ့်အားကိုယ်ကိုး ထရန်စဖေါ်မာတည်ဆောက်ခြင်းလုပ်ငန်းမှ ဓာတ်အားခွဲရုံတည်ဆောက်ခြင်းလုပ်ငန်းများအား အောက်ဖော်ပြပါ သတ်မှတ်ချက်များအတိုင်း ဆောင်ရွက်ရမည် ဖြစ်ပါသည်။"),
        Column(
          children: rules2.map((title) => _getRulesTxt(title)).toList(),
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

  void goToBack() {
    Navigator.of(context).pop();
  }

  Widget cancelButton() {
    return ElevatedButton(
      onPressed: () {
        goToBack();
      },
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

  Widget _getHeaderRulesTxt(title) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.7, color: Colors.black26)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
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

  Widget getHeaderRulesTxt(title) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.7, color: Colors.black26)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
    Navigator.pushNamed(context, 'ygn_t_form02_promise');
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
