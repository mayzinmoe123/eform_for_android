import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form03_money_mdy.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form03_money.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form03_money.dart';

class TForm02PromiseMdy extends StatefulWidget {
  const TForm02PromiseMdy({Key? key}) : super(key: key);

  @override
  State<TForm02PromiseMdy> createState() => _TForm02PromiseMdyState();
}

class _TForm02PromiseMdyState extends State<TForm02PromiseMdy> {
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
                """လျှောက်ထားသူသည် ယခုထရန်စဖေါ်မာ လျှောက်ထားခြင်းအတွက် မည်သူကိုမျှ လာဘ်ငွေ၊ တံစိုးလက်ဆောင် တစ်စုံတစ်ရာ ပေးရခြင်းမရှိပါ။"""),
            _getRulesTxt(
                """ထရန်စဖေါ်မာတည်ဆောက်ခွင့် ရရှိပါက သက်မှတ်ထားသော စံချိန်စံညွှန်းများနှင့်အညီ တည်ဆောက်သွားပါမည်။"""),
            _getRulesTxt(
                """သတ်မှတ်ကြေးငွေများကို တစ်လုံးတစ်ခဲတည်း ပေးသွင်းသွားမည်ဖြစ်ပြီး ဓာတ်အားခများကိုလည်း လစဉ်ပုံမှန်ပေးချေသွားပါမည်။"""),
            _getRulesTxt(
              """တည်ဆဲဥပဒေ၊ စည်းမျဉ်းများနှင့် အခါအားလျှော်စွာ ထုတ်ပြန်သောအမိန့်နှင့် ညွှန်ကြားချက်များကို တိကျစွာလိုက်နာ ဆောင်ရွက်သွားပါမည်ဟု ဝန်ခံကတိပြုပါသည်။ """
            ),
            _getRulesTxt(
              """လျှောက်ထားသူသည် ဓာတ်အားသုံးစွဲခွင့် ရရှိပြီးနောက်ပိုင်းတွင် လိုအပ်လာပါက ဌာန၏ သတ်မှတ်ထားသော အခြားနေရာများသို့ ဓါတ်အားလိုင်းချိတ်ဆက်နိုင်စေရန် ခွင့်ပြုပေးရမည်ဖြစ်ပြီး ကန့်ကွက်ရန် မရှိကြောင်း ဝန်ခံကတိပြုပါသည်။"""
            ),
          
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
                            builder: (context) => TForm03MoneyMdy()));
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
