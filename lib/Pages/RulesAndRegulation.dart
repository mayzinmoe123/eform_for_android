import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/Pages/Promise.dart';
// import 'package:flutter_application_1/Pages/MeterApplyChoice.dart';

import './Login.dart';
import './MeterApplyChoice.dart';
import './Promise.dart';

class RulesAndRegulations extends StatefulWidget {
  const RulesAndRegulations({Key? key}) : super(key: key);

  @override
  State<RulesAndRegulations> createState() => _RulesAndRegulationsState();
}

class _RulesAndRegulationsState extends State<RulesAndRegulations> {
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
                """ပူးတွဲတင်ပြသည့် အိမ်ထောင်စုစာရင်း၊ နိုင်ငံသားစိစစ်ရေးကဒ်၊ လိုင်စင်၊ စာချုပ်စာတမ်း၊ ထောက်ခံချက်စသည့် အထောက်အထားစာရွက်စာတမ်းများနှင့် ဓာတ်ပုံများကို ထင်ရှားမြင်သာ ပေါ်လွင်ပြီး ဖျက်ရာပြင်ရာမပါရှိရန်။"""),
            _getRulesTxt(
                """ပူးတွဲပါစာရွက်စာတမ်းများ မပြည့်စုံခြင်း၊ ထင်ရှားမှု၊ ပြတ်သားမှုမရှိပါက လျှောက်လွှာအား ထည့်သွင်းစဉ်းစားမည် မဟုတ်ပါ။"""),
            _getRulesTxt(
                """ပူတရားဝင်နေထိုင်ကြောင်းထောက်ခံစာနှင့် ကျူးကျော်မဟုတ်ကြောင်းထောက်ခံစာများသည် (၁ လ) အတွင်းရယူထားသော ထောက်ခံစာများဖြစ်ရမည်။"""),
            _getRulesTxt(
                """မီတာ/ထရန်စဖေါ်မာ လျှောက်ထားသူ၏ အိမ်အမှတ် / တိုက်အမှတ် / တိုက်ခန်းအမှတ်၊ လမ်းအမည်၊ လမ်းသွယ်အမည်၊ ရပ်ကွပ်အမည် နှင့် မြို့နယ်/ကျေးရွာ အမည်တို့ကို တိကျမှန်ကန်စွာ ဖြည့်သွင်းပေးရမည်။"""),
            _getRulesTxt(
                """ပူးတွဲပါစာရွက်စာတမ်းများအား အင်ဂျင်နီယာဌာနမှ ကွင်းဆင်းစစ်ဆေးသည့် အချိန်တွင် စစ်ဆေးသွားမည် ဖြစ်ပြီး စာရွက်စာတန်းများအား အတုပြုလုပ်ခြင်း၊ ပြင်ဆင်ခြင်းများ တွေ့ရှိပါက တည်ဆဲဥပဒေအရ ထိရောက်စွာ အရေးယူခြင်းခံရမည် ဖြစ်ပါသည်။"""),
            _getRulesTxt(
                """မြို့ပေါ်နှင့် ကျေးရွာလယ်ယာမြေပေါ်တည်ဆောက်ထားသော လူနေအိမ်များ၊ အဆောက်အဦးများ၊ စီးပွားရေးလုပ်ငန်းများနှင့် စက်မှုလုပ်ငန်းများအတွက် လယ်ယာမြေအား အခြားနည်း သုံးစွဲခွင့် လျှောက်ထား၍ ခွင့်ပြုချက် ရရှိပြီးမှသာလျှင် မီတာ/ထရန်စဖော်မာတပ်ဆင်သုံးစွဲခွင့်ပြုမည်။"""),
            _getRulesTxt(
                """ပူထရန်စဖော်မာ/မီတာလျှောက်ထားနိုင်ရန် ပိုင်ဆိုင်မှုအထောက်အထားတင်ပြရာတွင် ကျူးကျော်မြေ၊ အများပိုင်မြေနှင့် အမွေဆိုင်မြေများဖြင့် လျှောက်ထားခြင်းမဟုတ်ဘဲတစ်ဦးတည်းပိုင်ဆိုင်သော မြေဖြစ်ရန် လိုအပ်ပါသည်။"""),
            _getRulesTxt(
                """မီတာတပ်ဆင်မည့် အဆောက်အဦးအား ဘေးပတ်ဝန်းကျင်နှင့် အဆောက်အဦးပေါ်လွင်အောင် ဓာတ်ပုံရိုက်ပြီး မှန်မှန်ကန်ကန် ပူးတွဲတင်ပြရန်။"""),
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Promise()));
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text(
                      "လုပ်ဆောင်မည်",
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            )
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
}
