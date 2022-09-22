import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../models/application_form_model.dart';
import '../../../models/constructor_form.dart';

class COverview extends StatefulWidget {
  const COverview({Key? key}) : super(key: key);

  @override
  State<COverview> createState() => _COverviewState();
}

class _COverviewState extends State<COverview> {
  int? formId;
  bool showFormCheck = true;
  bool showMeterTypeCheck = false;
  bool showNRCCheck = false;
  bool showHouseholdCheck = false;
  bool showRecommendCheck = false;
  bool showOwernshipCheck = false;
  bool showFarmLandCheck = false;
  bool showAllowCheck = false;
  bool showLiveCheck = false;
  bool showYCDCCheck = false;
  bool showMeterBillCheck = false;
  bool showBuildingCheck = false;

  String formText = "";
  Map? form;
  Map? cform;
  List? colName;
  List? feeName;
  bool chkSend = false;
  List files = [];
  bool isLoading = true;
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
    var url = Uri.parse('${apiPath}api/constructor_show');
    try {
      var response = await http
          .post(url, body: {'token': token, 'form_id': formId.toString()});
      Map data = jsonDecode(response.body);
      if (data['success']) {
        stopLoading();
        refreshToken(data['token']);
        print(data);
        setState(() {
          form = data['form'];
          cform = data['c_form'];
          files = data['files'];
          colName = data['tbl_col_name'];
          feeName = data['fee_names'];
          chkSend = data['chk_send'];
          msg = data['msg'];
          state = data['state'];
          result = data;
          formText =
              "          အထက်ပါကိစ္စနှင့်ပတ်သက်၍ ${result!['address'] ?? '-'}တွင် ကန်ထရိုက်တိုက် (${result!['c_form']['room_count'] ?? '-'} ခန်း) အတွက် အိမ်သုံးမီတာ(${result!['c_form']['meter'] ?? '-'}လုံး)၊ ";

          if ((result!['c_form']['pMeter10']??0) > 0 ||
              (result!['c_form']['pMeter10']??0) > 0 ||
              (result!['c_form']['pMeter10']??0) > 0) {
            formText =
                "$formText ပါဝါမီတာ(${result!['c_form']['pMeter10'] + result!['c_form']['pMeter20'] + result!['c_form']['pMeter30']}လုံး)";
          }
          if (result!['c_form']['water_meter'] == 1) {
            formText = '$formText ရေစက်မီတာ(1လုံး)';
          }

          if (result!['c_form']['water_meter'] == 1) {
            formText = '$formTextဓါတ်လှေကားအသုံးပြုရန် ပါဝါမီတာ(၁)လုံး';
          }
          formText = '$formTextတပ်ဆင်သုံးစွဲခွင့်ပြုပါရန်လျှောက်ထားအပ်ပါသည်။';
        });
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
    return  isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body:  body(context),
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
                  context, 'mdy_c_form04_info',
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

            //အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား
            mainTitle("အခန်းအရေအတွက် နှင့်\nမီတာအမျိုးအစား ",
                showMeterTypeCheck, meterTypeToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form03_money_type', arguments: {
                'form_id': formId,
                'edit': true,
                'cForm': ConstructorForm.mapToObject(cform!)
              });
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showMeterTypeCheck == true ? showMeterTypeTable() : Container(),
            SizedBox(height: 20),

            //မှတ်ပုံတင်ရှေ့ဖက်
            mainTitle("မှတ်ပုံတင်အမှတ်", showNRCCheck, nrcToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form05_n_r_c',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showNRCCheck == true
                ? singleTwo(files, 'nrc_copy_front', 'မှတ်ပုံတင်အရှေ့ဘက်',
                    'nrc_copy_back', 'မှတ်ပုံတင်အနောက်ဘက်')
                : Container(),
            SizedBox(height: 20),

            //အိမ်ထောင်စုစာရင်း
            mainTitle("အိမ်ထောင်စုစာရင်း (မူရင်း)", showHouseholdCheck,
                householdToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form06_household',
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
                  context, 'mdy_c_form07_recommend',
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
                    'နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ',
                    'no_invade_letter',
                    'ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ')
                : Container(),
            SizedBox(height: 20),

            //ပိုင်ဆိုင်မှုစာရွက်စာတမ်း
            mainTitle("ပိုင်ဆိုင်မှုစာရွက်စာတမ်း (မူရင်း)", showOwernshipCheck,
                ownershipToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form08_ownership',
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

            //ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)
            mainTitle("ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)", showAllowCheck,
                allowToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form09_allow',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showAllowCheck == true
                ? singleOne(files, 'building_permit',
                    "ဆောက်လုပ်ခွင့် အထောက်အထားဓါတ်ပုံ(မူရင်း)")
                : Container(),
            SizedBox(height: 20),

            //လူနေထိုင်ခွင့် (မူရင်း)
            mainTitle(
                "လူနေထိုင်ခွင့် (မူရင်း)", showLiveCheck, liveToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form10_live',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showLiveCheck == true
                ? singleOne(
                    files, 'bcc', "လူနေထိုင်ခွင့် အထောက်အထားဓါတ်ပုံ(မူရင်း)")
                : Container(),
            SizedBox(
              height: 20,
            ),

            //စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)
            mainTitle(
                "စည်ပင်ထောက်ခံစာ (မူရင်း)", showYCDCCheck, ycdcToggleButton,
                () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form11_y_c_d_c',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showYCDCCheck == true
                ? singleOne(
                    files, 'dc_recomm', "စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)")
                : Container(),
            SizedBox(height: 20),

            //နောက်ဆုံးပေးဆောင်ထားသော (မီတာ/ယာယီမီတာ) ချလံ ဓါတ်ပုံ (မူရင်း)
            mainTitle("နောက်ဆုံးပေးဆောင်ထားသော\n(မီတာ/ယာယီမီတာ)ချလံ(မူရင်း)",
                showMeterBillCheck, meterBillToggleButton, () async {
              startLoading();
              final result = await Navigator.pushNamed(
                  context, 'mdy_c_form12_meter_bill',
                  arguments: {'form_id': formId, 'edit': true});
              setState(() {
                formId = (result ?? 0) as int;
              });
              getFormData();
            }),
            SizedBox(height: 10),
            showMeterBillCheck == true
                ? singleOne(files, 'prev_bill',
                    "နောက်ဆုံးပေးဆောင်ထားသော\n(မီတာ/ယာယီမီတာ)ချလံဓါတ်ပုံ(မူရင်း)")
                : Container(),
            SizedBox(height: 20),

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

  Widget textSpan(String txt1, String txt2) {
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
          ),
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

  Widget showMeterTypeTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        color: Colors.grey,
      ),
      children: [
        getTableBodyDetail(
            "အခန်းအရေအတွက်", "${cform!['room_count'] ?? '-'} ခန်း"),
        getTableBodyDetail(
            "အိမ်သုံးမီတာ အရေအတွက်", "${cform!['meter'] ?? '-'} လုံး"),
        getTableBodyDetail("ပါဝါမီတာ အရေအတွက်",
            "10KW - ${cform!['pMeter10'] ?? '-'} လုံး \n 20KW - ${cform!['pMeter20'] ?? '-'} လုံး \n 30KW - ${cform!['pMeter30'] ?? '-'} လုံး"),
        getTableBodyDetail(
            "ရေစက်မီတာ", cform!['water_meter'] > 0 ? 'ပါသည်' : 'မပါပါ'),
        getTableBodyDetail(
            "ဓါတ်လှေကားမီတာ", cform!['elevator_meter'] > 0 ? 'ပါသည်' : 'မပါပါ'),
      ],
    );
  }

  Widget showForm() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text(
            "ကန်ထရိုက်တိုက် မီတာ လျှောက်လွှာပုံစံ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [textSpan("အမှတ်စဥ် -", form!['serial_code'] ?? '-')]),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(child: Text("သို့"))),
              Text("  မြို့နယ်လျှပ်စစ်မှူး/မြို့နယ်လျှပ်စစ်အင်ဂျင်နီယာ"),
              Text("  မန္တလေးလျှပ်စစ်ဓာတ်အားပေးရေးကော်ပိုရေးရှင်း"),
              Text("  ${result!['township_name'] ?? '-'}"),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text("ရက်စွဲ။   ။ ${result!['date'] ?? '-'}"),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            textSpan("အကြောင်းအရာ။   ။",
                " ကန်ထရိုက်တိုက်မီတာတပ်ဆင်ခွင့်ပြုပါရန်လျှောက်ထားခြင်း။")
          ]),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formText,
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

  meterTypeToggleButton() {
    setState(() {
      showMeterTypeCheck = !showMeterTypeCheck;
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

  allowToggleButton() {
    setState(() {
      showAllowCheck = !showAllowCheck;
    });
  }

  liveToggleButton() {
    setState(() {
      showLiveCheck = !showLiveCheck;
    });
  }

  ycdcToggleButton() {
    setState(() {
      showYCDCCheck = !showYCDCCheck;
    });
  }

  meterBillToggleButton() {
    setState(() {
      showMeterBillCheck = !showMeterBillCheck;
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
