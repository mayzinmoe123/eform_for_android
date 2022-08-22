import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form03_money.dart';

class RpForm02PromiseMdy extends StatefulWidget {
  const RpForm02PromiseMdy({Key? key}) : super(key: key);

  @override
  State<RpForm02PromiseMdy> createState() => _RpForm02PromiseMdyState();
}

class _RpForm02PromiseMdyState extends State<RpForm02PromiseMdy> {
  var checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "စည်းမျဥ်းစည်းကမ်းများ",
            style: TextStyle(fontFamily: "Pyidaungsu", fontSize: 20),
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
                """လျှောက်ထားသူသည် ယခုအိမ်သုံးပါဝါမီတာ လျှောက်ထားခြင်းအတွက် မည်သူကိုမျှ လာဘ်ငွေ၊ တံစိုးလက်ဆောင် တစ်စုံတစ်ရာ ပေးရခြင်းမရှိပါ။"""),
            _getRulesTxt(
                """သတ်မှတ်ကြေးငွေများကို တစ်လုံးတစ်ခဲတည်း ပေးသွင်းသွားမည်ဖြစ်ပြီး ဓာတ်အားခများကိုလည်း လစဉ်ပုံမှန်ပေးချေသွားပါမည်။"""),
            _getRulesTxt(
                """တည်ဆဲဥပဒေ၊ စည်းမျဉ်းများနှင့် အခါအားလျှော်စွာ ထုတ်ပြန်သောအမိန့်နှင့် ညွှန်ကြားချက်များကို တိကျစွာလိုက်နာ ဆောင်ရွက်သွားပါမည်ဟု ဝန်ခံကတိပြုပါသည်။"""),
            _getRulesTxt(
              """မီတာတပ်ဆင်သည့်နေရာတွင် ကန့်ကွက်မှု တစ်စုံတစ်ရာ ဖြစ်ပွားပါက မီတာဖြုတ်သိမ်းခြင်းကို သဘောတူပါသည်။"""
            ),
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
                            builder: (context) => RpForm03MoneyMdy()));
                      }
                      ;
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
