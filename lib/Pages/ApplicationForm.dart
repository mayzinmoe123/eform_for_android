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
  // List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  // List<String> _aa = ['A', 'B', 'C', 'D']; // Option 2
  // String _selectedLocation = 'a'; // Option 2
  // List _jobs = [
  //   {"key": 1, "value": "အစိုးရဝန်ထမ်း"},
  //   {"key": 2, "value": "ဝန်ထမ်း"},
  //   {"key": 3, "value": "အခြား"},
  // ];
  var jobs = {'အစိုးရဝန်ထမ်း', "ဝန်ထမ်း", "အခြား"};
  // var jops = {1, 2, 3};
  // // print(_jobs);
  var _selectedjobs = null;
  // var _selectedjobs = 1;
  var isVisible = false;
  var isVisibleOther = false;
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: DropdownButtonFormField<String>(
                      hint: Text("အလုပ်အကိုင်"),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                      ),
                      value: _selectedjobs,
                      elevation: 16,
                      // dropdownColor: Colors.black12,
                      // style: TextStyle(color: Colors.blue),
                      items: jobs.map((data) {
                        return DropdownMenuItem(
                            value: data,
                            child: Text(
                              data,
                              // style: TextStyle(backgroundColor: Colors.blueGrey),
                            ));
                      }).toList(),
                      // isExpanded: true,
                      // style: TextStyle(color: Colors.black26),
                      onChanged: (value) {
                        _selectedjobs = value!;
                        setState(() {
                          // print(_selectedjobs);
                          if (_selectedjobs == 'ဝန်ထမ်း') {
                            isVisible = true;
                            isVisibleOther = false;
                          }
                          if (_selectedjobs == 'အစိုးရဝန်ထမ်း') {
                            isVisible = true;
                            isVisibleOther = false;
                          }

                          if (_selectedjobs == 'အခြား') {
                            isVisibleOther = true;
                            isVisible = false;
                          }

                          // elseif() {
                          //   isVisibleOther = !isVisibleOther;
                          // }

                          // if (_selectedjobs == 'အခြား') {}
                        });
                      }),
                ),
                // if(_jobs == 'အစိုးရဝန်ထမ်း')
                Visibility(visible: isVisible, child: _getForm("ရာထူး***")),
                Visibility(
                    visible: isVisible, child: _getForm("ဌာန/ကုမ္ပဏီ***")),
                Visibility(visible: isVisible, child: _getForm("ပျမ်းမျှလစာ")),
                Visibility(visible: isVisibleOther, child: _getForm("အခြား")),
                Visibility(
                    visible: isVisibleOther, child: _getForm("ပျမ်းမျှလစာ")),
                _getForm("အိမ်/တိုက်အမှတ် ***"),
                _getForm("တိုက်ခန်းအမှတ်"),
                _getForm("လမ်းအမည်***"),
                _getForm("လမ်းသွယ်အမည်"),
                _getForm("ရပ်ကွက်အမည်***"),
                _getForm("မြို့နယ်***"),
                _getForm("ခရိုင်***"),
                _getForm("တိုင်းဒေသကြီး/ပြည်နယ်***"),
                SizedBox(
                  width: 20,
                ),
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
                ),
                SizedBox(
                  width: 20,
                ),
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
