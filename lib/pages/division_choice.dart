import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/account_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DivisionChoice extends StatefulWidget {
  const DivisionChoice({Key? key}) : super(key: key);

  @override
  State<DivisionChoice> createState() => _DivisionChoiceState();
}

class _DivisionChoiceState extends State<DivisionChoice> {
  int selectedBottom = 0;
  bool isLoading = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? userName;
  String? userEmail;

  List forms = [];

  @override
  void initState() {
    super.initState();
  }

  void getForms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var apiPath = prefs.getString('api_path');
    var url = Uri.parse('${apiPath}api/overall_process');

    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
    });

    try {
      var response = await http.post(url, body: {'token': token});
      print('response.body ${response.body}');
      Map data = jsonDecode(response.body);
      print('data $data');
      if (data['success'] == true) {
        stopLoading();
        refreshToken(data['token']);
        setState(() {
          forms = data['forms'];
        });
      } else {
        stopLoading();
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      print('http error $e');
      stopLoading();
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
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
    return isLoading
        ? loading()
        : Scaffold(
            key: scaffoldKey,
            appBar: applicationBar(context),
            body: body(context),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dataset), label: 'လျှောက်လွှာပုံစံများ'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sort), label: 'လုပ်ငန်းစဉ်အားလုံး'),
              ],
              currentIndex: selectedBottom,
              onTap: (value) {
                setState(() {
                  selectedBottom = value;
                });
                if (selectedBottom == 1) {
                  startLoading();
                  getForms();
                } else {
                  stopLoading();
                }
              },
            ),
            endDrawer: AccountSetting(),
          );
  }

  AppBar applicationBar(
    BuildContext context,
  ) {
    return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "မီတာလျှောက်လွှာပုံစံများ",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.manage_accounts),
              onPressed: () {
                print('open end drawer');
                scaffoldKey.currentState?.openEndDrawer();
              }),
        ]);
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
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: selectedBottom == 0 ? divisionWidget() : processWidget());
  }

  Widget divisionWidget() {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        divisionLink("ရန်ကုန်တိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း", () {
          Navigator.pushNamed(context, '/yangon/meter');
        }),
        const SizedBox(height: 10.0),
        divisionLink("မန္တလေးတိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း", () {
          Navigator.pushNamed(context, 'mdy_meter');
        }),
        const SizedBox(height: 10.0),
        divisionLink("အခြားတိုင်းဒေသကြီး/ပြည်နယ်များတွင် မီတာလျှောက်ထားခြင်း",
            () {
          Navigator.pushNamed(context, 'other_meter');
        }),
      ],
    );
  }

  Widget divisionLink(String title, VoidCallback _onTapfun) {
    return GestureDetector(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 16.0),
          ),
          leading: const Icon(Icons.map),
          trailing: InkWell(
            onTap: _onTapfun,
            child: const Icon(Icons.arrow_circle_right, color: Colors.blue),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      )),
      onTap: _onTapfun,
      onDoubleTap: _onTapfun,
    );
  }

  Widget processWidget() {
    return Container(
      child: forms.length > 0
          ? ListView.builder(
              itemCount: forms.length,
              itemBuilder: (context, index) {
                return swipListItem(context, forms[index]);
              },
            )
          : Container(
              color: Colors.orange,
              padding: EdgeInsets.all(30),
              child: Text(
                'သင်မီတာလျှောက်လွှာများ မလျှောက်ထားရသေးပါ။ လျှောက်လွှာပုံစံများတွင် တိုင်းဒေသကြီးရွေး၍ လျှောက်ထားနိုင်ပါသည်။',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
    );
  }

  String getMeterType(value) {
    if (value == 1) {
      return 'အိမ်သုံး';
    } else if (value == 2) {
      return 'အိမ်သုံးပါဝါ';
    } else if (value == 3) {
      return 'လုပ်ငန်းသုံးပါဝါ';
    } else if (value == 4) {
      return 'ထရန်စဖော်မာ';
    } else {
      return 'ကန်ထရိုက်တိုက်';
    }
  }

  Widget swipListItem(BuildContext context, Map<dynamic, dynamic> form) {
    String serial = form['serial_code'] != null ? form['serial_code'] : '-';
    String meterType =
        form['apply_type'] != null ? getMeterType(form['apply_type']) : '-';
    String fullname = form['fullname'] != null ? form['fullname'] : '-';
    String address = form['div_name'] != null ? form['div_name'] : '-';
    String date = form['date_f'] != null ? form['date_f'] : '-';
    String state = form['state'] != null ? form['state'] : '-';

    // ygn = 1, mdy = 3,other=2
    String div = form['apply_division'].toString();
    // R = 1, RP = 2, CP = 3, T=4, C=5
    String type = form['apply_type'].toString();

    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              formTitle(serial),
              formMeterType(meterType),
              formFullName(fullname),
              formAddress(address),
              formDate(date),
              formState(state),
            ],
          ),
        ),
      ),
      onTap: () {
        goToDetailPage(context, form);
      },
    );
  }

  Widget formTitle(String text) {
    return Text(
      'လျှောက်လွှာအမှတ်စဥ် : $text',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  Widget formMeterType(String text) {
    return Text(
      'မီတာအမျိုးအစား : $text',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget formFullName(String text) {
    return Text(
      'နာမည် : $text',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget formAddress(String text) {
    return Text(
      'လိပ်စာ : $text',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget formDate(String text) {
    return Text(
      'နေ့စွဲ : $text',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget formState(String text) {
    return Text(
      'အခြေအနေ : $text',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  void stopLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
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

  void goToDetailPage(BuildContext context, Map form) async {
    print('go to detail');
    print('form $form');
    if (form['apply_type'] != null && form['apply_division'] != null) {
      // ygn = 1, mdy = 3,other=2
      String div = form['apply_division'].toString();
      // R = 1, RP = 2, CP = 3, T=4, C=5
      String type = form['apply_type'].toString();
      String routeName = getRouteName(div, type);
      print('routeName $routeName');
      var result = await Navigator.pushNamed(context, routeName,
          arguments: {'form_id': form['id']});
      if (result != null) {
        startLoading();
        getForms();
      }
    }
  }

  String getRouteName(div, type) {
    String routeName = '';
    if (div == '1') {
      routeName = yangonRoute(type);
    } else if (div == '3') {
      routeName = mandalayRoute(type);
    } else if (div == '2') {
      routeName = otherRoute(type);
    }
    return routeName;
  }

  String yangonRoute(String type) {
    String routeName = '';
    switch (type) {
      case '1':
        routeName = '/yangon/residential/overview';
        break;
      case '2':
        routeName = '/yangon/residential_power/overview';
        break;
      case '3':
        routeName = '/yangon/commerical_power/overview';
        break;
      case '5':
        routeName = 'ygn_c_overview';
        break;
      case '4':
        routeName = 'ygn_t_overview';
        break;
      default:
        routeName = 'ygn_t_overview';
    }
    return routeName;
  }

  String mandalayRoute(String type) {
    String routeName = '';
    switch (type) {
      case '1':
        routeName = 'mdy_r_overview';
        break;
      case '2':
        routeName = 'mdy_rp_overview';
        break;
      case '3':
        routeName = 'mdy_cp_overview';
        break;
      case '5':
        routeName = 'mdy_c_overview';
        break;
      case '4':
        routeName = 'mdy_t_overview';
        break;
      default:
        routeName = 'mdy_t_overview';
    }
    return routeName;
  }

  String otherRoute(String type) {
    String routeName = '';
    switch (type) {
      case '1':
        routeName = 'other_r_overview';
        break;
      case '2':
        routeName = 'other_rp_overview';
        break;
      case '3':
        routeName = 'other_cp_overview';
        break;
      case '5':
        routeName = 'other_c_overview';
        break;
      case '4':
        routeName = 'other_t_overview';
        break;
      default:
        routeName = 'other_t_overview';
    }
    return routeName;
  }
}
