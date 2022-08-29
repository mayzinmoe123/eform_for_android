import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class COverview extends StatefulWidget {
  const COverview({Key? key}) : super(key: key);

  @override
  State<COverview> createState() => _COverviewState();
}

class _COverviewState extends State<COverview> {
  int? formId;
  bool showFormCheck = true;
  bool showMeterTypeCheck = false;
  bool showMoneyCheck = false;
  bool showNRCCheck = false;
  bool showHouseholdCheck = false;
  bool showRecommendCheck = false;
  bool showOwernshipCheck = false;
  bool showAllowCheck = false;
  bool showLiveCheck = false;
  bool showYCDCCheck = false;
  bool showMeterBillCheck = false;
  bool showFarmLandCheck = false;
  bool showBuildingCheck = false;
  bool showPowerCheck = false;
  bool showApartmentCheck = false;
  bool showBuilingDrawingCheck = false;
  bool showLocationCheck = false;
  bool showSignCheck = false;
  bool isLoading = false;
  bool showCurrentMeterCheck =false;

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
            // showForm(),
            SizedBox(height: 20),

            //ကိုယ်ရေးအချက်အလက်
            mainTitle("ကိုယ်ရေးအချက်အလက်", showFormCheck, formToggleButton),
            SizedBox(
              height: 10,
            ),
            showFormCheck == true ? showForm() : Container(),
            SizedBox(
              height: 20,
            ),

             //အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား
            hideEditmainTitle("အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား ", showMeterTypeCheck,
                meterTypeToggleButton),
            SizedBox(
              height: 10,
            ),
            showMeterTypeCheck == true ? showMeterTypeTable() : Container(),
            SizedBox(
              height: 20,
            ),

            //မှတ်ပုံတင်ရှေ့ဖက်
            mainTitle("မှတ်ပုံတင်အမှတ်", showNRCCheck, nrcToggleButton),
            SizedBox(
              height: 10,
            ),
            showNRCCheck == true
                ?showSingleImage("မှတ်ပုံတင်ရှေ့ဖက် (မူရင်း)","မှတ်ပုံတင်နောက်ဖက် (မူရင်း)")
       : Container(),
             SizedBox(
              height: 20,
            ),
            //အိမ်ထောင်စုစာရင်း
            mainTitle(
                "အိမ်ထောင်စုစာရင်း (မူရင်း)", showHouseholdCheck, householdToggleButton),
            SizedBox(
              height: 10,
            ),
            showHouseholdCheck == true
                ? showMultiImages("အိမ်ထောင်စုစာရင်းရှေ့ဖက် (မူရင်း)","အိမ်ထောင်စုစာရင်းနောက်ဖက် (မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),
            //ထောက်ခံစာ 
            mainTitle(
                "ထောက်ခံစာ (မူရင်း)", showRecommendCheck , recommendToggleButton),
            SizedBox(
              height: 10,
            ),
            showRecommendCheck == true
                ? showSingleImage("နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း)","ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း)"
                    )
                : Container(),
                 SizedBox(
              height: 20,
            ),
            
             //ပိုင်ဆိုင်မှုစာရွက်စာတမ်း
            mainTitle(
                "ပိုင်ဆိုင်မှုစာရွက်စာတမ်း (မူရင်း)", showOwernshipCheck, ownershipToggleButton),
            SizedBox(
              height: 10,
            ),
            showOwernshipCheck == true
                ? multiImageFront("ပိုင်ဆိုင်မှုစာရွက်စာတမ်း (မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)
            mainTitle(
                "ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)", showAllowCheck , allowToggleButton),
            SizedBox(
              height: 10,
            ),
            showAllowCheck  == true
                ? singleImageFront("ဆောက်လုပ်ခွင့် အထောက်အထားဓါတ်ပုံ(မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //လူနေထိုင်ခွင့် (မူရင်း)
            mainTitle(
                "လူနေထိုင်ခွင့် (မူရင်း)", showLiveCheck  , liveToggleButton),
            SizedBox(
              height: 10,
            ),
            showLiveCheck   == true
                ? singleImageFront("လူနေထိုင်ခွင့် အထောက်အထားဓါတ်ပုံ(မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)
            mainTitle(
                "စည်ပင်ထောက်ခံစာ (မူရင်း)", showYCDCCheck   , ycdcToggleButton),
            SizedBox(
              height: 10,
            ),
            showYCDCCheck    == true
                ? singleImageFront("စည်ပင်ထောက်ခံစာဓါတ်ပုံ(မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

            //နောက်ဆုံးပေးဆောင်ထားသော (မီတာ/ယာယီမီတာ) ချလံ ဓါတ်ပုံ (မူရင်း)
            mainTitle(
                "နောက်ဆုံးပေးဆောင်ထားသော\n(မီတာ/ယာယီမီတာ)ချလံ(မူရင်း)", showMeterBillCheck    , meterBillToggleButton),
            SizedBox(
              height: 10,
            ),
            showMeterBillCheck    == true
                ? singleImageFront("နောက်ဆုံးပေးဆောင်ထားသော\n(မီတာ/ယာယီမီတာ)ချလံဓါတ်ပုံ(မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //လယ်ယာပိုင်မြေဖြစ်ပါက လယ်ယာပိုင်မြေအား အခြားနည်းဖြင့်သုံးဆွဲရန်ခွင့်ပြုချက် 
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("လယ်ယာပိုင်မြေဖြစ်ပါက လယ်ယာပိုင်မြေအား အခြားနည်းဖြင့်သုံးဆွဲရန်ခွင့်ပြုချက် (မူရင်း)"),
             ),
            mainTitle(
                "သုံးဆွဲရန်ခွင့်ပြုချက် (မူရင်း)", showFarmLandCheck, farmlandToggleButton),
            SizedBox(
              height: 10,
            ),
            showFarmLandCheck == true
                ? multiImageFront("ခွင့်ပြုချက်ဓါတ်ပုံ (မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //အဆောက်အဦးဓါတ်ပုံ
             mainTitle(
                "အဆောက်အဦးဓါတ်ပုံ", showBuildingCheck, buildingToggleButton),
            SizedBox(
              height: 10,
            ),
            showBuildingCheck == true
                ? multiImageFront("အဆောက်အဦးဓါတ်ပုံ ")
                : Container(),
                 SizedBox(
              height: 20,
            ),


             //တိုက်ပုံစံဓါတ်ပုံ
             mainTitle(
                "တိုက်ပုံစံဓါတ်ပုံ", showApartmentCheck, apartmentToggleButton),
            SizedBox(
              height: 10,
            ),
            showApartmentCheck == true
                ? multiImageFront("တိုက်ပုံစံဓါတ်ပုံ ")
                : Container(),
                 SizedBox(
              height: 20,
            ),

             //အဆောက်အဦး Drawing
             mainTitle(
                "အဆောက်အဦး Drawing", showBuilingDrawingCheck, buildingDrawingToggleButton),
            SizedBox(
              height: 10,
            ),
            showBuilingDrawingCheck == true
                ? multiImageFront("အဆောက်အဦး Drawing ")
                : Container(),
                 SizedBox(
              height: 20,
            ),

            //တည်နေရာပြမြေပုံ
             mainTitle(
                "တည်နေရာပြမြေပုံ", showLocationCheck,locationToggleButton),
            SizedBox(
              height: 10,
            ),
            showLocationCheck == true
                ? multiImageFront("တည်နေရာပြမြေပုံ ")
                : Container(),
                 SizedBox(
              height: 20,
            ),

           //ရေစက်မီတာလျှောက်ထားရာတွင် ကန်ထရိုက်ရှိ အခန်းစေ့နေသူများ၏ ကန့်ကွက်မှုမရှိကြောင်း လက်မှတ်ရေးထိုးထားမှုစာ (မူရင်း)
            Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("ရေစက်မီတာလျှောက်ထားရာတွင် ကန်ထရိုက်ရှိ အခန်းစေ့နေသူများ၏ ကန့်ကွက်မှုမရှိကြောင်း လက်မှတ်ရေးထိုးထားမှုစာ (မူရင်း)"),
             ),
             mainTitle(
                "လက်မှတ်ရေးထိုးထားမှုစာ(မူရင်း)", showSignCheck,signToggleButton),
            SizedBox(
              height: 10,
            ),
            showSignCheck == true
                ? multiImageFront("လက်မှတ်ရေးထိုးထားမှုစာ (မူရင်း)")
                : Container(),
                 SizedBox(
              height: 20,
            ),

            actionButton(context),
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
        child: Text("ပေးပို့မည်", style: TextStyle(fontSize: 15)));
  }

  Widget textSpan(txt1, txt2) {
    return Flexible(
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(text: txt1),
            new TextSpan(
                text: txt2,
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

Widget mainTitle(String title, bool checkVal, VoidCallback checkState) {
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
          InkWell(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text("ပြင်ဆင်ရန်",
                      style: TextStyle(fontSize: 15, color: Colors.red)))),
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

  Widget showMeterTypeTable(){
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(
        color: Colors.grey,
      ),
      children: [
        getTableBodyDetail("အခန်းအရေအတွက်", "၁၁၀ ခန်း ( ၁၀ ခန်းတွဲ x ၁၁ ထပ် )"),
        getTableBodyDetail("အိမ်သုံးမီတာ အရေအတွက်", "၁၁၀ လုံး"),
        getTableBodyDetail("ရေစက်မီတာ", "မပါပါ"),
        getTableBodyDetail("ဓါတ်လှေကားမီတာ", "မပါပါ"),
      ],
    );
  }
  
  // Widget showMoneyTable() {
  //   return Table(
  //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //     border: TableBorder.all(
  //       color: Colors.grey,
  //     ),
  //     children: [
  //       _getTableHeader(
  //           "အကြောင်းအရာများ", ["ကောက်ခံရမည့်နှုန်းထား (ကျပ်)", "Type Three"]),
  //       getTableBodyDetail("မီတာသတ်မှတ်ကြေး", "၈၀,၀၀၀"),
  //       getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀"),
  //       getTableBodyDetail("လိုင်းကြိုး (ဆက်သွယ်ခ)", "၂,၀၀၀"),
  //       getTableBodyDetail("မီးဆက်ခ", "၂,၀၀၀"),
  //       getTableBodyDetail("ကြီးကြပ်ခ", "၁,၀၀၀"),
  //       getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၁,၀၀၀"),
  //       getTableFooter("စုစုပေါင်း", "၉၀,၀၀၀"),
  //     ],
  //   );
  // }

  Widget showForm() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text(
            "ကန်ထရိုက်တိုက်မီတာ လျှောက်လွှာပုံစံ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [textSpan("အမှတ်စဥ် -", "YGN-1661485206")]),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(child: Text("သို့"))),
              Text("  မြို့နယ်လျှပ်စစ်မန်နေဂျာ"),
              Text("  ရန်ကုန်လျှပ်စစ်ဓာတ်အားပေးရေးကော်ပိုရေးရှင်"),
              Text("  မင်္ဂလာတောင်ညွှန့်မြို့နယ်"),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              "ရက်စွဲ။   ။ ၂၆-၀၈-၂၀၂၂",
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            textSpan("အကြောင်းအရာ။   ။",
                "ကန်ထရိုက်တိုက်မီတာတပ်ဆင်ခွင့်ပြုပါရန်လျှောက်ထားခြင်း။")
          ]),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "          အထက်ပါကိစ္စနှင့်ပတ်သက်၍အမှတ် (142)၊ Innwa၊ 6 block၊ မင်္ဂလာတောင်ညွှန့်မြို့နယ်၊ရန်ကုန်အရှေ့ပိုင်းခရိုင်၊ရန်ကုန်တိုင်းဒေသကြီးတွင် ကန်ထရိုက်တိုက် (၁၀ ခန်းတွဲ x ၁၁ ထပ် = ၁၁၀ ခန်း) အတွက် အိမ်သုံးမီတာ (၁၁၀) လုံး တပ်ဆင်သုံးစွဲခွင့်ပြုပါရန်လျှောက်ထားအပ်ပါသည်။",
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "    တပ်ဆင်သုံးစွဲခွင့်ပြုပါကလျှပ်စစ်ဓာတ်အားဖြန့်ဖြူးရေးလုပ်ငန်းမှသတ်မှတ်ထားသောအခွန်အခများကိုအကြေပေးဆောင်မည့်အပြင်တည်ဆဲဥပဒေများအတိုင်းလိုက်နာဆောင်ရွက်မည်ဖြစ်ပါကြောင်းနှင့်အိမ်တွင်းဝါယာသွယ်တန်းခြင်းလုပ်ငန်းများကိုလျှပ်စစ်ကျွမ်းကျင်လက်မှတ်ရှိသူများနှင့်သာဆောင်ရွက်မည်ဖြစ်ကြောင်းဝန်ခံကတိပြုလျှောက်ထားအပ်ပါသည်။",
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "တပ်ဆင်သုံးစွဲလိုသည့် လိပ်စာ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                  "အမှတ် (142)၊ Innwa၊ 6 block၊မင်္ဂလာတောင်ညွှန့်မြို့နယ်၊ ရန်ကုန်အရှေ့ပိုင်းခရိုင်၊ ရန်ကုန်တိုင်းဒေသကြီး၊"),
              SizedBox(
                height: 14,
              ),
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
                      child: Container(child: Text(" Si Thu Myo"))),
                  Text("  ၁၂/အစန(နိုင်)၁၂၃၄၅၆"),
                  Text("  09123456789"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget singleImageFront(title) {
    return Column(
      children: [
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
            ],
          ),
        )),
        SizedBox(
              height: 10,
            ),
      ],
    );
  }

  Widget singleImageBack(title) {
    return Column(
      children: [
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
            ],
          ),
        )),
      ],
    );
  }

    Widget showSingleImage(frontTitle,backTitle){
    return Column(
      children: [
        singleImageFront(frontTitle),
        SizedBox(height: 10,),
        singleImageBack(backTitle),
      ],
    );
  }


  Widget multiImageFront(title) {
    return Column(
      children: [
        Card(
          elevation: 10,
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
              SizedBox(
              height: 10,
            ),
              Image.network(
                "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
              SizedBox(
              height: 10,
            ),
              Image.network(
                "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
            ],
          ),
        )),
      ],
    );
  }

  Widget multiImageBack(title) {
    return Column(
      children: [
        Card(
          elevation: 10,
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
              SizedBox(
              height: 10,
            ),
              Image.network(
                "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
              SizedBox(
              height: 10,
            ),
              Image.network(
                "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1",
                width: 300,
                height: 200,
              ),
              Text(title),
            ],
          ),
        )),
      ],
    );
  }

   Widget showMultiImages(frontTitle,backTitle){
    return Column(
      children: [
        multiImageFront(frontTitle),
        SizedBox(height: 10,),
         multiImageBack(backTitle),
      ],
    );
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

  meterTypeToggleButton(){
    setState(() {
      showMeterTypeCheck = !showMeterTypeCheck;
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
  buildingToggleButton() {
    setState(() {
      showBuildingCheck = !showBuildingCheck;
    });
  }
  powerToggleButton() {
    setState(() {
      showPowerCheck = !showPowerCheck;
    });
  }

  currentMeterToggleButton(){
    setState(() {
      showCurrentMeterCheck = !showCurrentMeterCheck;
    });
  }

  allowToggleButton(){
    setState(() {
      showAllowCheck = !showAllowCheck;
    });
  }

  liveToggleButton(){
    setState(() {
      showLiveCheck = !showLiveCheck;
    });
  }

  ycdcToggleButton(){
    setState(() {
      showYCDCCheck = !showYCDCCheck;
    });
  }

  meterBillToggleButton(){
    setState(() {
      showMeterBillCheck = !showMeterBillCheck;
    });
  }

  apartmentToggleButton(){
    setState(() {
      showApartmentCheck = !showApartmentCheck;
    });
  }

  buildingDrawingToggleButton(){
    setState(() {
      showBuilingDrawingCheck = !showBuilingDrawingCheck;
    });
  }

  locationToggleButton(){
    setState(() {
      showLocationCheck = !showLocationCheck;
    });
  }

  signToggleButton(){
    setState(() {
      showSignCheck = !showSignCheck;
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
