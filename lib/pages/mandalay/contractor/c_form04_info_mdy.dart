import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CForm04InfoMdy extends StatefulWidget {
  const CForm04InfoMdy({Key? key}) : super(key: key);

  @override
  State<CForm04InfoMdy> createState() => _CForm04InfoMdyState();
}

class _CForm04InfoMdyState extends State<CForm04InfoMdy> {
  int? formId;
  bool isLoading = true;

  String? _selectedjob;
  bool jobError = false;
  List<Map> jobs = [
    {
      "key": "gstaff",
      "value": "အစိုးရဝန်ထမ်း",
    },
    {
      "key": "staff",
      "value": "ဝန်ထမ်း",
    },
    {
      "key": "other",
      "value": "အခြား",
    }
  ];

  dynamic _selectedTownship;
  List<dynamic> townshipList = [];
  bool townshipError = false;
  int? townshipId;
  int? districtId;
  int? divisionId;

  TextStyle inputTextStyle = TextStyle(fontSize: 14.0);

  final _infoFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nrcController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController homeNoController = TextEditingController();
  TextEditingController laneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController quarterController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController townshipController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController divisionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTownshipList();
  }

  void getTownshipList() async {
    print('getting townships list');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    String apiPath = prefs.getString('api_path').toString();
    String division = '3'; // ygn = 2, mdy = 3, other = 1/4/5/..(expect 2/3)

    try {
      var url = Uri.parse(
          '${apiPath}api/township_dropdown?token=$token&division_id=$division');
      print('wanting townships list $url');
      var response = await http.get(url);
      print('response is $response');
      Map data = jsonDecode(response.body);
      if (data['success']) {
        setState(() {
          townshipList = data['townships'];
        });
        print('township list is $townshipList');
      } else {
        showAlertDialog(
            'Connection Failed!',
            'There is a problem while retrieving the townships list. Please try later or connect to developer team',
            context);
        print('check token error');
      }
      stopLoading();
    } catch (e) {
      stopLoading();
      showAlertDialog(
          'Connection Failed!', 'Check your internet connection', context);
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
    return WillPopScope(
      child: Scaffold(
        appBar: applicationBar(formId),
        body: isLoading ? loading() : body(context),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
    );
  }

  AppBar applicationBar(formId) {
    return AppBar(
      title: Text("ကိုယ်တိုင်ရေးလျှောက်လွှာပုံစံ",
          style: TextStyle(fontSize: 18.0)),
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: _infoFormKey,
          child: Column(
            children: [
              SizedBox(height: 15),
              requiredNoti(),
              SizedBox(height: 13),
              _getFormRequired("နာမည်အပြည့်အစုံ", nameController),
              _getFormRequired("မှတ်ပုံတင်အမှတ်", nrcController,
                  "ဥပမာ - ၁၂/အစန(နိုင်)၁၂၃၄၅၆"),
              _getFormRequired("ဆက်သွယ်ရမည့်ဖုန်း နံပါတ်", phoneController,
                  "အင်္ဂလိပ်စာဖြင့်သာ (ဥပမာ - 09123456 (သို့) 09123456789)"),
              _getFormRequired("အိမ်/တိုက်အမှတ်", homeNoController),
              _getFormRequired("လမ်းအမည်", streetController),
              _getFormOptional("လမ်းသွယ်အမည်", laneController),
              _getFormRequired("ရပ်ကွက်အမည်", quarterController),
              _getFormOptional("မြို့အမည်", townController),
              townshipDropdown(),
              townshipError
                  ? errorText('မြို့နယ်ရွေးချယ်ရန်လိုအပ်ပါသည်')
                  : SizedBox(),
              _getFormRequiredReadonly("ခရိုင်", districtController, context,
                  'ခရိုင်ကို ကိုယ်တိုင်ဖြည့်သွင်းရန်မလိုပါ။ "မြို့နယ်"ရွေးချယ်ပြီးပါက ဖြည့်သွင်းပြီးဖြစ်သွားပါလိမ့်မည်။'),
              _getFormRequiredReadonly(
                  "တိုင်းဒေသကြီး/ပြည်နယ်",
                  divisionController,
                  context,
                  'တိုင်းဒေသကြီး/ပြည်နယ်ကို ကိုယ်တိုင်ဖြည့်သွင်းရန်မလိုပါ။ "မြို့နယ်"ရွေးချယ်ပြီးပါက ဖြည့်သွင်းပြီးဖြစ်သွားပါလိမ့်မည်။'),
              SizedBox(width: 20),
              actionButtons(),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(color: Colors.red[800], fontSize: 11.5),
        textAlign: TextAlign.left,
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

  Widget _getFormRequired(String name, TextEditingController textController,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${name}ကို ထည့်ပါ။";
          }
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

  Widget _getFormRequiredReadonly(
      String name, TextEditingController textController, BuildContext context,
      [hintTxt]) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[200],
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: TextFormField(
            controller: textController,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: name,
              // helperText: hintTxt,
              helperStyle: TextStyle(color: Colors.red),
            ),
            style: TextStyle(fontSize: 14)),
      ),
      onTap: () {
        showSnackBar(context, "$hintTxt");
      },
    );
  }

  Widget _getFormOptional(String name, TextEditingController textController,
      [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget jobField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: DropdownButtonFormField(
          hint: requiredText("အလုပ်အကိုင်"),
          decoration: InputDecoration(
            label: requiredText('အလုပ်အကိုင်'),
            isDense: true,
            border: const OutlineInputBorder(),
          ),
          elevation: 16,
          items: jobs.map((jobData) {
            return DropdownMenuItem(
              value: jobData['key'],
              child: Text(jobData['value']),
            );
          }).toList(),
          onChanged: (selected) {
            setState(() {
              _selectedjob = selected.toString();
            });
          }),
    );
  }

  Widget townshipDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: DropdownButtonFormField<dynamic>(
        hint: requiredText("မြို့နယ်"),
        decoration: InputDecoration(
          isDense: true,
          label: requiredText("မြို့နယ်"),
          border: OutlineInputBorder(),
        ),
        value: _selectedTownship,
        elevation: 16,
        items: townshipList.map((data) {
          return DropdownMenuItem(
            value: data,
            child: Text(data['name'], style: inputTextStyle),
          );
        }).toList(),
        onChanged: (selected) {
          print('township dropdown $selected');
          setState(() {
            districtController.text = selected['district_name'];
            divisionController.text = selected['division_states_name'];
            _selectedTownship = selected!;
            townshipId = selected['id'];
            districtId = selected['district_id'];
            divisionId = selected['division_state_id'];
          });
        },
      ),
    );
  }

  bool checkDropDowns() {
    bool check = true;
    // checking townshipdropdown
    if (townshipId == null || townshipId == '') {
      setState(() {
        townshipError = true;
      });
      check = false;
    } else {
      setState(() {
        townshipError = false;
      });
    }

    return check;
  }

  Widget actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () => goToBack(),
            style: ElevatedButton.styleFrom(primary: Colors.black12),
            child: Text("မပြုလုပ်ပါ")),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            if (checkDropDowns() & _infoFormKey.currentState!.validate()) {
              startLoading();
              saveInfo();
            } else {
              print('validate error');
            }
          },
          child: Text("ဖြည့်သွင်းမည်"),
        ),
      ],
    );
  }

  void saveInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiPath = prefs.getString('api_path').toString();
    String token = prefs.getString('token').toString();
    var url = Uri.parse("${apiPath}api/applicant_info_contractor");
    try {
      var response = await http.post(url, body: {
        'token': token,
        'form_id': formId.toString(),
        'fullname': nameController.text,
        'nrc': nrcController.text,
        'applied_phone': phoneController.text,
        'applied_home_no': homeNoController.text,
        'applied_street': streetController.text,
        'applied_lane': laneController.text,
        'applied_quarter': quarterController.text,
        'applied_town': townController.text,
        'township_id': townshipId.toString(),
        'district_id': districtId.toString(),
        'div_state_id': divisionId.toString()
      });

      // http resonse {success: false, validate: {applied_home_no: [The applied home no field is required.], applied_street: [The applied street field is required.], township_id: [The township id field is required.], district: [The district field is required.], region: [The region field is required.]}}

      Map data = jsonDecode(response.body);
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
        // showAlertDialog(data['title'], data['message'], context);
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

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  void goToNextPage() async {
    final result = await Navigator.pushNamed(context, 'mdy_c_form05_n_r_c',
        arguments: {'form_id': formId});
    setState(() {
      formId = (result ?? 0) as int;
    });
    stopLoading();
    print('info-nrc-page form id is $formId');
  }

  void goToBack() {
    Navigator.of(context).pop(formId);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
