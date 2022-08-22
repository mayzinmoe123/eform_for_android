// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form02_promise_mdy.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form02_promise.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form02_promise.dart';

class TForm01RulesMdy extends StatefulWidget {
  const TForm01RulesMdy({Key? key}) : super(key: key);

  @override
  State<TForm01RulesMdy> createState() => _TForm01RulesMdyState();
}

class _TForm01RulesMdyState extends State<TForm01RulesMdy> {
  var checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "စည်းမျဥ်းစည်းကမ်းများ",
            style: TextStyle(fontFamily: "Burmese", fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _getRulesTxt(
                """မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားရာတွင် ဌာနမှပူးတွဲတင်ပြရန် သက်မှတ်ထားသော စာရွက်စာတမ်းများအား ထင်ရှားပြတ်သားစွာ ဓါတ်ပုံရိုက်ယူ၍သော်လည်ကောင်း၊ Scan ဖတ်၍သော်လည်ကောင်း ပူးတွဲတင်ပြပေးရမည်။"""),
            _getRulesTxt(
                """ပူးတွဲပါစာရွက်စာတမ်းများ မပြည့်စုံခြင်း၊ ထင်ရှားမှု၊ ပြတ်သားမှုမရှိပါက လျှောက်လွှာအား ထည့်သွင်းစဉ်းစားမည် မဟုတ်ပါ။"""),
            _getRulesTxt(
                """တရားဝင်နေထိုင်ကြောင်းထောက်ခံစာနှင့် ကျူးကျော်မဟုတ်ကြောင်းထောက်ခံစာများသည် (၁ လ) အတွင်းရယူထားသော ထောက်ခံစာများဖြစ်ရမည်။"""),
            _getRulesTxt(
                """မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားသူ၏ အိမ်အမှတ် / တိုက်အမှတ် / တိုက်ခန်းအမှတ်၊ လမ်းအမည်၊ လမ်းသွယ်အမည်၊ ရပ်ကွပ်အမည် နှင့် မြို့နယ်/ကျေးရွာ အမည်တို့ကို တိကျမှန်ကန်စွာ ဖြည့်သွင်းပေးရမည်။"""),
            _getRulesTxt(
                """ပူးတွဲပါစာရွက်စာတမ်းများအား အင်ဂျင်နီယာဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့် အချိန်တွင် စစ်ဆေးသွားမည် ဖြစ်ပြီး စာရွက်စာတန်းများအား အတုပြုလုပ်ခြင်း၊ ပြင်ဆင်ခြင်းများ တွေ့ရှိပါက တည်ဆဲဥပဒေအရ ထိရောက်စွာ အရေးယူခြင်းခံရမည် ဖြစ်ပါသည်။"""),
            _getHeaderRulesTxt(
                "ကိုယ့်အားကိုယ်ကိုး ထရန်စဖေါ်မာတည်ဆောက်ခြင်းလုပ်ငန်းမှ ဓာတ်အားခွဲရုံတည်ဆောက်ခြင်းလုပ်ငန်းများအား အောက်ဖော်ပြပါ သတ်မှတ်ချက်များအတိုင်း ဆောင်ရွက်ရမည် ဖြစ်ပါသည်။"),
            _getRulesTxt(
                """ထရန်စဖေါ်မာတပ်ဆင်ထားသော နေရာသည် လွယ်ကူစွာ ကြည့်ရှုနိုင်သော ဝန်းခြံအရှေ့မျက်နှာစာ နေရာမျိုးဖြစ်ရမည်။"""),
            _getRulesTxt(
                """နည်းပညာ စံချိန်စံညွှန်းနှင့် ကိုက်ညီမှုရှိသော အမျိုးအစားကောင်းမွန်သည့် ထရန်စဖေါ်မာကိုသာ တပ်ဆင်ရမည်။"""),
            _getRulesTxt(
                """Protection အတွက် HT Side တွင် Lightning Arrestor, Disconnection Switch, Drop Out Fuse (with respected fuse link), Enclosed Cutout Fuse တပ်ဆင်ရန်နှင့် Lightning Arrestor ကို Transformer ၏ HT Bushing နှင့် အနီးဆုံးနေရာတွင် တပ်ဆင်ရမည်။"""),
            _getRulesTxt(
                """ဗို့အားကျဆင်မှုမဖြစ်ပွားစေရန် LT Side တွင်အမျိုးအစားကောင်းမွန်သော Capacitor Bank တပ်ဆင်၍ အမြဲတမ်း အလုပ်လုပ်စေပြီး ချို့ယွင်းပျက်စီးပါက ချက်ချင်းအသစ်တစ်လုံး တပ်ဆင်ရမည်။"""),
            _getRulesTxt(
                """L.T Sideတွင် 400V Distribution Panel ( 4P – NFB + (Volt + Ampere) Meter + Pilot Lamp + Voltage Selector Switch ) တပ်ဆင်ရန်နှင့် ထရန်စဖေါ်မာ၏ LT Bushing Cap တပ်ဆင်၍ Seal ခတ်ရမည်။"""),
            _getRulesTxt(
                """Earthing System အတွက် သတ်မှတ်ထားသော earth result ရရှိရမည်ဖြစ်ပြီး earth mesh မှ L.A ၊ D.S ၊ DOF, Transformer Body နှင့် Neutral သို့ earth wire တစ်ချောင်းစီဖြင့် သီးသန့်ဆက်သွယ်ရမည်။ လျှပ်စစ်စစ်ဆေးရေးဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့်အချိန်တွင် သတ်မှတ်ထားသော earth result မရရှိခြင်းနှင့် သတ်မှတ်ထားသော ညွှန်ကြားချက်များအတိုင်း လိုက်နာဆောင်ရွက်ခြင်းမရှိပါက ပြန်လည်ပြုပြင်ပေးရမည်။"""),
            _getRulesTxt(
                """မြေ/အဆောက်အဉီးဆိုင်ရာ အငြင်းပွားခြင်း၊ ဓာတ်အားသုံးစွဲသည့် လုပ်ငန်းနှင့် ပက်သက်၍ ကန့်ကွက်ခြင်းများ ပေါ်ပေါက်လာပါက ခွင့်ပြုမိန့်ရုပ်သိမ်း၍ ဓာတ်အားဖြတ်တောက်ခြင်း ဆောင်ရွက်သွားရမည်ကို သိရှိလိုက်နာရမည်။"""),
            _getRulesTxt(
                """ရုံးမှ ဓာတ်လွှတ်ရန် ခွင့်ပြုမိန့်ရရှိမှသာ ဓာတ်အားလွှတ်၍ မီးသုံးစွဲရမည်။"""),
            _getCheckBox(
                "အထက်ပါ စည်းမျဥ်းစည်းကမ်းများကို နားလည်သိရှိပါက လိုက်နာရန် အမှန်ခြစ်ပါ။"),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    // style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    //
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: Colors.grey),
                    child: Text(
                      "မပြုလုပ်ပါ",
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (checkedValue == true) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TForm02PromiseMdy()));
                      }
                      ;
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text(
                      "လုပ်ဆောင်မည်",
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRulesTxt(title) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.7, color: Colors.black26)),
      ),
      child: ListTile(
        // leading: Text(
        //   String.fromCharCode(0x2022),
        //   style: TextStyle(fontSize: 35),
        // ),
        leading: Icon(Icons.arrow_right_alt_outlined),
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

  Widget _getHeaderRulesTxt(title) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.7, color: Colors.black26)),
      ),
      child: ListTile(
        // leading: Text(
        //   String.fromCharCode(0x2022),
        //   style: TextStyle(fontSize: 35),
        // ),
        // leading: Icon(Icons.arrow_right_alt_outlined),
        title: Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
