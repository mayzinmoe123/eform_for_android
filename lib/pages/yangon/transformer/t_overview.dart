import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../models/application_form_model.dart';

class TOverview extends StatefulWidget {
  const TOverview({Key? key}) : super(key: key);

  @override
  State<TOverview> createState() => _TOverviewState();
}

class _TOverviewState extends State<TOverview> {
  int? formId;
  bool showFormCheck = true;
  bool showMoneyCheck = false;
  bool showNRCCheck = false;
  bool showHouseholdCheck = false;
  bool showRecommendCheck = false;
  bool showOwernshipCheck = false;
  bool showFarmLandCheck = false;
  bool showBuildingCheck = false;
  bool showPowerCheck = false;
  bool showLicenseCheck = false;
  bool showCurrentMeterCheck = false;
  bool showYCDCCheck = false;
  bool showZoneCheck = false;

  bool isLoading = true;

  Map? form;
  List? colName;
  List? feeName;
  bool chkSend = false;
  List files = [];
  String msg = '';
  String state = 'send';

  String? townshipName;
  String? address;
  String? date;
  Map? result;

  @override
  void initState() {
    super.initState();
    getFormData();
  }

  void getFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var apiPath = prefs.getString('api_path');
    var url = Uri.parse('${apiPath}api/ygn_t_show');
    try {
      var response = await http
          .post(url, body: {'token': token, 'form_id': formId.toString()});
      Map data = jsonDecode(response.body);
      if (data['success']) {
        stopLoading();
        refreshToken(data['token']);
        setState(() {
          form = data['form'];
          files = data['files'];
          colName = data['tbl_col_name'];
          feeName = data['fee_names'];
          chkSend = data['chk_send'];
          msg = data['msg'];
          state = data['state'];
          result = data;
        });
        print('files $files');
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
    print('form_id is $formId');
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
      title:
          const Text("အချက်အလက်အပြည့်အစုံ", style: TextStyle(fontSize: 18.0)),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          goToBack();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            goToHomePage(context);
          },
          icon: const Icon(
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
    var mSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            title(),
            SizedBox(height: 20),
            Container(
              color: Colors.amber,
              padding: EdgeInsets.all(20),
              child: Text(
                msg,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 20),

            //ကိုယ်ရေးအချက်အလက်
            mainTitle("ကိုယ်ရေးအချက်အလက်", showFormCheck, formToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form04_info',
                  arguments: {
                    'form_id': formId,
                    'edit': true,
                    'appForm': ApplicationFormModel.mapToObject(form!),
                  });
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showFormCheck == true ? showForm() : Container(),
            SizedBox(height: 20),

            //မီတာအမျိုးအစား
            mainTitle("လျှောက်ထားသည့်\nမီတာအမျိုးအစား ", showMoneyCheck,
                moneyToggleButton, () async {
              startLoading();
              String navName = form!['apply_tsf_type'] == 2
                  ? 'ygn_ct_form03_money_type'
                  : 'ygn_t_form03_money_type';
              final result =
                  await Navigator.pushNamed(context, navName, arguments: {
                'form_id': formId,
                'edit': true,
                'pole_type': form!['pole_type'],
              });
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showMoneyCheck == true ? showMoneyTable() : Container(),
            SizedBox(height: 20),

            //မှတ်ပုံတင်ရှေ့ဖက်
            mainTitle("မှတ်ပုံတင်အမှတ်", showNRCCheck, nrcToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form05_n_r_c',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showNRCCheck == true
                ? singleTwo(
                    files,
                    'nrc_copy_front',
                    'မှတ်ပုံတင်ရှေ့ဖက် (မူရင်း)',
                    'nrc_copy_back',
                    'မှတ်ပုံတင်နောက်ဖက် (မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //အိမ်ထောင်စုစာရင်း
            mainTitle("အိမ်ထောင်စုစာရင်း (မူရင်း)", showHouseholdCheck,
                householdToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form06_household',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showHouseholdCheck == true
                ? multiTwo(
                    files,
                    'form_10_front',
                    'အိမ်ထောင်စုစာရင်းရှေ့ဖက် (မူရင်း)',
                    'form_10_back',
                    'အိမ်ထောင်စုစာရင်းနောက်ဖက် (မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //ထောက်ခံစာ
            mainTitle(
                "ထောက်ခံစာ (မူရင်း)", showRecommendCheck, recommendToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form07_recommend',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showRecommendCheck == true
                ? singleTwo(
                    files,
                    'occupy_letter',
                    'နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း)',
                    'no_invade_letter',
                    'ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //ပိုင်ဆိုင်မှုစာရွက်စာတမ်း
            mainTitle("ပိုင်ဆိုင်မှုစာရွက်စာတမ်း (မူရင်း)", showOwernshipCheck,
                ownershipToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form08_ownership',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showOwernshipCheck == true
                ? multiOne(
                    files, 'ownership', 'ပိုင်ဆိုင်မှုစာရွက်စာတမ်း (မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း)
            mainTitle("လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း)", showLicenseCheck,
                licenseToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form09_lincense',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showLicenseCheck == true
                ? multiOne(files, 'transaction_licence',
                    'လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)
            mainTitle(
                "စည်ပင်ထောက်ခံစာ (မူရင်း)", showYCDCCheck, ycdcToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form10_dc',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showYCDCCheck == true
                ? singleOne(
                    files, 'dc_recomm', 'စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //လယ်ယာပိုင်မြေဖြစ်ပါက လယ်ယာပိုင်မြေအား အခြားနည်းဖြင့်သုံးဆွဲရန်ခွင့်ပြုချက်
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "လယ်ယာပိုင်မြေဖြစ်ပါက လယ်ယာပိုင်မြေအား အခြားနည်းဖြင့်သုံးဆွဲရန်ခွင့်ပြုချက် (မူရင်း)"),
            ),
            mainTitle("သုံးဆွဲရန်ခွင့်ပြုချက် (မူရင်း)", showFarmLandCheck,
                farmlandToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form11_farmland',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showFarmLandCheck == true
                ? multiOne(files, 'farmland', 'ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //စက်မှုဇုံဖြစ်ပါက ဇုံကော်မတီ၏ ထောက်ခံချက်(မူရင်း)
            mainTitle("စက်မှုဇုံဖြစ်ပါကဇုံကော်မတီ၏\nထောက်ခံချက်(မူရင်း)",
                showZoneCheck, zoneToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form12_zone',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showZoneCheck == true
                ? multiOne(files, 'industry',
                    'စက်မှုဇုံဖြစ်ပါက ဇုံကော်မတီ၏ ထောက်ခံချက်(မူရင်း)')
                : Container(),
            SizedBox(height: 20),

            //အသုံးပြုမည့် ဝန်အားစာရင်း
            mainTitle("အသုံးပြုမည့် ဝန်အားစာရင်း (မူရင်း)", showPowerCheck,
                powerToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'ygn_t_form13_power',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(
              height: 10,
            ),
            showPowerCheck == true
                ? multiOne(files, 'electric_power',
                    'အသုံးပြုမည့် ဝန်အားစာရင်း (မူရင်း)')
                : Container(),
            SizedBox(
              height: 20,
            ),

            chkSend ? actionButton(context) : SizedBox(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Center(
      child: Text(
        'လျှောက်ထားသူ၏ အချက်အလက်အပြည့်အစုံ',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget actionButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          sendDialog('ရုံးသို့ပို့ရန် သေချာပါသလား?',
              'ရုံးသို့ပို့ရန် သေချာပါက ပေးပို့မည်ကိုနှိပ်ပါ။', context);
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20)),
        child: Text("ပေးပို့မည်", style: TextStyle(fontSize: 15)));
  }

  Widget textSpan(txt1, txt2) {
    return Flexible(
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(
              text: txt1,
              style: new TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontFamily: "Pyidaungsu",
              ),
            ),
            new TextSpan(
              text: txt2,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black,
                fontFamily: "Pyidaungsu",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainTitle(String title, bool checkVal, VoidCallback checkState,
      VoidCallback editLink) {
    var mSize = MediaQuery.of(context).size;
    return ElevatedButton(
      child: InkWell(
        onTap: checkState,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              )),
          Flexible(
            child: state != 'send' || chkSend == true
                ? InkWell(
                    onTap: editLink,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text("ပြင်ဆင်ရန်",
                            style: TextStyle(fontSize: 15, color: Colors.red))))
                : SizedBox(),
          )
        ]),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ))),
      onPressed: () {
        checkVal;
      },
    );
  }

  Widget hideEditmainTitle(
      String title, bool checkVal, VoidCallback checkState) {
    var mSize = MediaQuery.of(context).size;
    return ElevatedButton(
      child: InkWell(
        onTap: checkState,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              )),
        ]),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ))),
      onPressed: () {
        checkVal;
      },
    );
  }

  String getPoleType(int type) {
    if (type == 1) {
      return "One Pole Type";
    } else if (type == 2) {
      return "Two Poles Type";
    } else if (type == 3) {
      return 'Package Type';
    } else {
      return '';
    }
  }

  Widget showMoneyTable() {
    var mSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: mSize.width,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: Text(getPoleType(form!['pole_type'] ?? 0),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(
            color: Colors.grey,
          ),
          children: [
            _getTableHeader("အကြောင်းအရာများ", [
              "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)",
              "${result!['fee']['name'] ?? '-'} KVA"
            ]),
            getTableBodyDetail(
                "မီတာသတ်မှတ်ကြေး", result!['fee']['assign_fee'] ?? '-'),
            getTableBodyDetail(
                "အာမခံစဘော်ငွေ", result!['fee']['deposit_fee'] ?? '-'),
            getTableBodyDetail(
                "လိုင်းကြိုး (ဆက်သွယ်ခ)", result!['fee']['string_fee'] ?? '-'),
            getTableBodyDetail("မီးဆက်ခ", result!['fee']['service_fee'] ?? '-'),
            getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး",
                result!['fee']['registration_fee'] ?? '-'),
            getTableFooter("စုစုပေါင်း", result!['fee']['total'].toString()),
          ],
        ),
      ],
    );
  }

  Widget showForm() {
    String tsfType;
    if (form!['apply_tsf_type'] != null) {
      tsfType = form!['apply_tsf_type'] == 2
          ? 'လုပ်ငန်းသုံးထရန်စဖော်မာ'
          : 'အိမ်သုံးထရန်စဖော်မာ';
    } else {
      tsfType = 'ထရန်စဖော်မာ';
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text(
            "$tsfType လျှောက်လွှာပုံစံ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 15),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [textSpan("အမှတ်စဥ် -", form!['serial_code']?? '-' )]),

          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(child: Text("သို့"))),
              Text("  မြို့နယ်လျှပ်စစ်မန်နေဂျာ"),
<<<<<<< HEAD
              Text("  ရန်ကုန်လျှပ်စစ်ဓာတ်အားပေးရေးကော်ပိုရေးရှင်း"),
              Text("  ${result!['township_name'] ?? '-'}"),
=======
              Text("  ရန်ကုန်လျှပ်စစ်ဓာတ်အားပေးရေးကော်ပိုရေးရှင်"),
              Text("  ${result!['township_name'] ?? '-' }"),

>>>>>>> 528ef73861ff59127a932209c2e05c10217944b2
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              "ရက်စွဲ။   ။ ${result!['date'] ?? '-'}",
            ),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            textSpan("အကြောင်းအရာ။   ။",
                "(${result!['fee']['name']} KVA) ထရန်စဖေါ်မာတစ်လုံးတည်ဆောက်တပ်ဆင်ခွင့်ပြုပါရန်လျှောက်ထားခြင်း။")
          ]),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
<<<<<<< HEAD
                "          အထက်ပါကိစ္စနှင့်ပတ်သက်၍ ${result!['address'] ?? '-'} နေကျွန်တော်/ကျွန်မ၏ ${form!['applied_building_type'] ?? '-'} တွင် ${result!['tsf_type'] ?? '-'}တပ်ဆင်သုံးစွဲခွင့်ပြုပါရန်လျှောက်ထားအပ်ပါသည်။",
=======
                "          အထက်ပါကိစ္စနှင့်ပတ်သက်၍ ${result!['address'] ?? '-'} နေကျွန်တော်/ကျွန်မ၏ ${form!['building_type'] ?? '-'} တွင် ${result!['tsf_type'] ?? '-' }တပ်ဆင်သုံးစွဲခွင့်ပြုပါရန်လျှောက်ထားအပ်ပါသည်။",
>>>>>>> 528ef73861ff59127a932209c2e05c10217944b2
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 5),
              Text(
                "    တပ်ဆင်သုံးစွဲခွင့်ပြုပါကလျှပ်စစ်ဓာတ်အားဖြန့်ဖြူးရေးလုပ်ငန်းမှသတ်မှတ်ထားသောအခွန်အခများကိုအကြေပေးဆောင်မည့်အပြင်တည်ဆဲဥပဒေများအတိုင်းလိုက်နာဆောင်ရွက်မည်ဖြစ်ပါကြောင်းနှင့်အိမ်တွင်းဝါယာသွယ်တန်းခြင်းလုပ်ငန်းများကိုလျှပ်စစ်ကျွမ်းကျင်လက်မှတ်ရှိသူများနှင့်သာဆောင်ရွက်မည်ဖြစ်ကြောင်းဝန်ခံကတိပြုလျှောက်ထားအပ်ပါသည်။",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                "တပ်ဆင်သုံးစွဲလိုသည့် လိပ်စာ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 7),
              Text(result!['address'] ?? '-'),
              SizedBox(height: 14),
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "လေးစားစွာဖြင့်",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(child: Text(form!['fullname'] ?? '-'))),
                  Text("  ${form!['nrc'] ?? '-'}"),
                  Text("  ${form!['applied_phone'] ?? '-'}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget multiOne(List files, String column, String title) {
    return Column(
        children: files.map((e) {
      return Column(
        children: [
          imagesWidget(e[column], title),
        ],
      );
    }).toList());
  }

  Widget multiTwo(List files, String column1, String title1, String column2,
      String title2) {
    return Column(
        children: files.map((file) {
      return Column(
        children: [
          imagesWidget(file[column1], title1),
          imagesWidget(file[column2], title2),
        ],
      );
    }).toList());
  }

  Widget singleOne(List files, String column, String title) {
    return Column(
        children: files.map((e) {
      return Column(
        children: [
          imageWidget(e[column], title),
        ],
      );
    }).toList());
  }

  Widget singleTwo(List files, String column1, String title1, String column2,
      String title2) {
    return Column(
        children: files.map((file) {
      return Column(
        children: [
          imageWidget(file[column1], title1),
          imageWidget(file[column2], title2),
        ],
      );
    }).toList());
  }

  Widget imagesWidget(String? urls, String title) {
    if (urls != null && urls != '') {
      List urlList = urls.split(",");
      int count = 1;
      return Column(
          children: urlList.map((url) {
        return Column(
          children: [
            imageWidget(url, '$title (${count++})'),
          ],
        );
      }).toList());
    } else {
      return Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text('ပုံတင်ထားခြင်းမရှိပါ။',
                  style: TextStyle(), textAlign: TextAlign.center),
            ),
            SizedBox(height: 10.0),
            Text(title),
          ],
        ),
      ));
    }
  }

//
  Widget imageWidget(String? url, String title) {
    try {
      return Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            url != null && url != ''
                ? Image.network(
                    result!['path'] + url,
                    width: double.infinity,
                    height: 200,
                  )
                : Container(
                    width: double.infinity,
                    child: Text('ပုံတင်ထားခြင်းမရှိပါ။',
                        style: TextStyle(), textAlign: TextAlign.center),
                  ),
            SizedBox(height: 10.0),
            Text(title),
          ],
        ),
      ));
    } catch (e) {
      return Container(
        width: double.infinity,
        child: Text('ပုံတင်ထားခြင်းမရှိပါ။',
            style: TextStyle(), textAlign: TextAlign.center),
      );
    }
  }

  TableRow _getTableHeader(String d1, List d2) {
    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            d1,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                d2[0],
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.grey)),
              ),
              child: Text(
                d2[1],
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    ]);
  }

  TableRow getTableBodyDetail(String d1, String d2) {
    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          d1,
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          d2,
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.right,
        ),
      )
    ]);
  }

  TableRow getTableFooter(String d1, String d2) {
    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          d1,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          d2,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      )
    ]);
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

  formToggleButton() {
    setState(() {
      showFormCheck = !showFormCheck;
      // showMoneyCheck = !showMoneyCheck;
    });
  }

  moneyToggleButton() {
    setState(() {
      showMoneyCheck = !showMoneyCheck;
    });
  }

  nrcToggleButton() {
    setState(() {
      showNRCCheck = !showNRCCheck;
    });
  }

  householdToggleButton() {
    setState(() {
      showHouseholdCheck = !showHouseholdCheck;
    });
  }

  recommendToggleButton() {
    setState(() {
      showRecommendCheck = !showRecommendCheck;
    });
  }

  ownershipToggleButton() {
    setState(() {
      showOwernshipCheck = !showOwernshipCheck;
    });
  }

  farmlandToggleButton() {
    setState(() {
      showFarmLandCheck = !showFarmLandCheck;
    });
  }

  powerToggleButton() {
    setState(() {
      showPowerCheck = !showPowerCheck;
    });
  }

  licenseToggleButton() {
    setState(() {
      showLicenseCheck = !showLicenseCheck;
    });
  }

  ycdcToggleButton() {
    setState(() {
      showYCDCCheck = !showYCDCCheck;
    });
  }

  zoneToggleButton() {
    setState(() {
      showZoneCheck = !showZoneCheck;
    });
  }

  void sendDialog(String title, String content, BuildContext context) {
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
                child: title != 'Unauthorized'
                    ? Text('မပြုလုပ်ပါ')
                    : logoutButton(),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  sendFile();
                },
                child: title != 'Unauthorized'
                    ? Text(
                        'ပေးပို့မည်',
                        style: TextStyle(color: Colors.white),
                      )
                    : logoutButton(),
              )
            ],
          );
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

  void sendFile() async {
    startLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiPath = prefs.getString('api_path').toString();
    String token = prefs.getString('token').toString();
    var url = Uri.parse("${apiPath}api/send_form");
    try {
      var response = await http.post(url, body: {
        'token': token,
        'form_id': formId.toString(),
      });

      Map data = jsonDecode(response.body);
      print('http resonse $data');

      if (data['success']) {
        stopLoading();
        setState(() {
          formId = data['form']['id'];
        });
        setState(() {
          chkSend = false;
          state = 'send';
          msg = 'သင့်လျှောက်လွှာအား ရုံးသို့ပေးပို့ပြီးဖြစ်ပါသည်။';
          formId = data['form']['id'];
        });
        showSnackBar(context, msg);
        refreshToken(data['token']);
        Navigator.pop(context);
        goToNextPage();
      } else {
        stopLoading();
        Navigator.pop(context);
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      stopLoading();
      Navigator.pop(context);
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
      print('check token error $e');
    }
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
    // final result = await Navigator.pushNamed(
    //     context, '/yangon/residential/Cpoverview',
    //     arguments: {'form_id': formId});
    // setState(() {
    //   formId = (result ?? 0) as int;
    // });
    // print('form id is $formId');
  }

  void goToBack() {
    Navigator.of(context).pop(formId);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
