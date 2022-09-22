import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/constructor_form.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  TextEditingController power10Controller = TextEditingController();
  TextEditingController power20Controller = TextEditingController();
  TextEditingController power30Controller = TextEditingController();
  TextEditingController meterController = TextEditingController();

  int roomCount = 0;
  bool checkedWaterValue = false;
  bool checkedElevatorValue = false;

  int? oldRoomCount;
  int? oldWater;
  int? oldElevator;

  int? formId;
  bool isLoading = false;

  bool edit = false;
  ConstructorForm? cForm;

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
    print('info form_id is $formId');
    if (data['edit'] != null && cForm == null) {
      setState(() {
        edit = data['edit'];
        cForm = data['cForm'];
        apartmentController.text = nullCheck(cForm!.apartmentCount);
        floorController.text = nullCheck(cForm!.floorCount);
        power10Controller.text = nullCheck(cForm!.pMeter10);
        power20Controller.text = nullCheck(cForm!.pMeter20);
        power30Controller.text = nullCheck(cForm!.pMeter30);
        meterController.text = nullCheck(cForm!.meter);

        roomCount = nullCheckNum(cForm!.roomCount);
        checkedWaterValue = nullCheckBool(cForm!.waterMeter);
        checkedElevatorValue = nullCheckBool(cForm!.elevatorMeter);
      });
    }
    return WillPopScope(
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

  String nullCheck(String? value) {
    if (value == null || value == '' || value == 'null') {
      return '';
    }
    return value;
  }

  int nullCheckNum(value) {
    if (value == null || value == '' || value == 'null') {
      return 0;
    }
    return int.parse(value);
  }

  bool nullCheckBool(value) {
    if (value == null || value == '' || value == 'null') {
      return false;
    }
    return int.parse(value) > 0 ? true : false;
  }

  AppBar applicationBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          "အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား",
          style: TextStyle(fontSize: 18),
        ),
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
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              requiredNoti(),
              formNumRequired("အခန်းတွဲ", apartmentController),
              formNumRequired("အထပ်", floorController),
              powerMeter(),
              residentialMeter(),
              otherMeter(),
              SizedBox(height: 15),
              actionButtons(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text requiredNoti() {
    return Text(
      "*ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
      style: TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  Widget _formNumberOptional(String name, TextEditingController textController,
      [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(fontSize: 14),
        onChanged: (value) {
          calculateRmeter();
        },
      ),
    );
  }

  Widget formNumRequired(String name, TextEditingController textController,
      [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          label: requiredText(name),
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(fontSize: 14),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${name}ကို ထည့်ပါ။";
          }
        },
        onChanged: (value) {
          calculateRmeter();
        },
      ),
    );
  }

  Widget requiredText(String label) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.0),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '*',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void calculateRmeter() {
    if (apartmentController.text != '' && floorController.text != '') {
      int room = int.parse(apartmentController.text);
      int floor = int.parse(floorController.text);
      int power10 =
          power10Controller.text != '' ? int.parse(power10Controller.text) : 0;
      int power20 =
          power20Controller.text != '' ? int.parse(power20Controller.text) : 0;
      int power30 =
          power30Controller.text != '' ? int.parse(power30Controller.text) : 0;
      int remain = (room * floor) - (power10 + power20 + power30);
      print('reamin is $remain');
      setState(() {
        meterController.text = remain.toString();
        roomCount = (room * floor);
      });
    } else {
      setState(() {
        meterController.text = '';
        roomCount = 0;
      });
    }
    _formKey.currentState!.validate();
  }

  Widget powerMeter() {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            _getTextHeader("ပါဝါမီတာ အရေအတွက်", null, FontWeight.bold, 15.0),
            _formNumberOptional("10 KW", power10Controller),
            _formNumberOptional("20 KW", power20Controller),
            _formNumberOptional("30 KW", power30Controller),
            _getTextHeader(
                "ပါဝါမီတာ ထည့်သွင်းလျှောက်ထားလိုလျှင် မိမိလျှောက်ထားလိုသော မီတာအမျိုးအစားတွင် အရေအတွက် ထည့်သွင်းပေးပါရန်။ ပါဝါမီတာမလိုအပ်ပါက ဖြည့်သွင်းရန်မလိုအပ်ပါ။",
                Colors.blue),
            SizedBox(height: 10),
          ],
        ));
  }

  Widget residentialMeter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        readOnly: true,
        // enabled: false,
        controller: meterController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          isDense: true,
          border: OutlineInputBorder(),
          labelText: "အိမ်သုံးမီတာ အရေအတွက်",
        ),
        validator: (value) {
          if (!(value == null || value.isEmpty)) {
            if (int.parse(value) < 0) {
              return "အိမ်သုံးမီတာ အရေအတွက်မှားယွင်းနေပါသည်။";
            }
          }
        },
        onTap: () {
          showSnackBar(context,
              'အိမ်သုံးမီတာအရေအတွက်သည် အခန်းတွဲနှင့် အထပ် မြှောက်ထားသည်မှ ပါဝါမီတာအရေအတွက်များကို နှုတ်ထားခြင်းဖြစ်သည်။ ကိုယ်တိုင်ဖြည့်သွင်းခြင်းမပြုလုပ်နိုင်ပါ။');
        },
      ),
    );
  }

  Widget otherMeter() {
    return Card(
        child: Column(
      children: [
        SizedBox(height: 15),
        Text("အခြားမီတာများ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        _getWaterCheckBox("ရေစက်မီတာ အသုံးပြုမည်"),
        _getElevatorCheckBox("ဓါတ်လှေကားမီတာ အသုံးပြုမည်"),
        SizedBox(height: 10),
        _getTextHeader(
            "ရေစက် / ဓါတ်လှေကား ) မီတာ အသုံးပြုလိုလျှင် အမှန်ခြစ်ပေးပါရန်၊ မီတာအမျိုးအစား(KW)နှင့် အရေအတွက်ကို သက်ဆိုင်ရာမြိုနယ် လျှပ်စစ်အင်ဂျင်နီယာရုံးမှ သတ်မှတ်ပေးသွားမည် ဖြစ်ပါသည်။",
            Colors.blue),
        SizedBox(height: 15),
      ],
    ));
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
        style: TextStyle(fontSize: 13),
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
        style: TextStyle(
          fontSize: 13,
        ),
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

  Widget actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            goToBack();
          },
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(), primary: Colors.grey),
          child: Text(
            "မပြုလုပ်ပါ",
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              startLoading();
              meterTypeSave();
            }
          },
          style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          child: Text(
            "လုပ်ဆောင်မည်",
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void meterTypeSave() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apiPath = pref.getString("api_path").toString();
    String token = pref.getString("token").toString();
    try {
      print("old token is $token");
      var url = Uri.parse("${apiPath}api/meter_tye_contractor");
      var bodyData = {
        'token': token,
        'form_id': formId != null ? formId.toString() : '',
        'apply_division': '1', // ygn=1, mdy=3, other=2
        'room_count': roomCount.toString(),
        'apartment_count': apartmentController.text,
        'floor_count': floorController.text,
        'pMeter10': power10Controller.text,
        'pMeter20': power20Controller.text,
        'pMeter30': power30Controller.text,
        'meter': meterController.text,
        'water_meter': checkedWaterValue ? 'ON' : 'OFF',
        'elevator_meter': checkedElevatorValue ? 'ON' : 'OFF',
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

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 10),
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
      final result = await Navigator.pushNamed(context, 'ygn_c_form04_info',
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
