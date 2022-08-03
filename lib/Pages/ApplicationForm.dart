import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/Pages/ApplicationFormNRC.dart';

import './ApplicationFormNRC.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({Key? key}) : super(key: key);

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ကိုယ်တိုင်ရေးလျှောက်လွှာပုံစံ"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 13,
                ),
                _getForm(
                  "နာမည်အပြည့်အစုံ***",
                ),
                _getForm("မှတ်ပုံတင်အမှတ်***", "ဥပမာ - ၁၂/အစန(နိုင်)၁၂၃၄၅၆"),
                _getForm("ဆက်သွယ်ရမည့်ဖုန်း နံပါတ်***",
                    "အင်္ဂလိပ်စာဖြင့်သာ (ဥပမာ - 09123456 (သို့) 09123456789)"),
                _getForm("အလုပ်အကိုင်"),
                _getForm("အဆောက်အဦးပုံစံ၊ အကျယ်အဝန်း၊ အိမ်အမျိုးအစာ***"),
                _getForm("အိမ်/တိုက်အမှတ် ***"),
                _getForm("တိုက်ခန်းအမှတ်"),
                _getForm("လမ်းအမည်***"),
                _getForm("လမ်းသွယ်အမည်"),
                _getForm("ရပ်ကွက်အမည်***"),
                _getForm("မြို့နယ်***"),
                _getForm("ခရိုင်***"),
                _getForm("တိုင်းဒေသကြီး/ပြည်နယ်***"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style:
                            ElevatedButton.styleFrom(primary: Colors.black12),
                        child: Text("မပြုလုပ်ပါ")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ApplicationFormNRC()));
                        },
                        child: Text("ဖြည့်သွင်းမည်")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForm(name, [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
