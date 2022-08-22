import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/pages/mandalay/contractor/c_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form04_info.dart';

class CForm03MeterTypeMdy extends StatefulWidget {
  const CForm03MeterTypeMdy({Key? key}) : super(key: key);

  @override
  State<CForm03MeterTypeMdy> createState() => _CForm03MeterTypeMdyState();
}

class _CForm03MeterTypeMdyState extends State<CForm03MeterTypeMdy> {
  
  final TextEditingController _apartmentCount = TextEditingController();
  final TextEditingController _floorCount = TextEditingController();
  TextEditingController valueTxt = TextEditingController();
  
  var checkedWaterValue = false;
  var checkedElevatorValue = false;

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("အခန်းအရေအတွက် နှင့် မီတာအမျိုးအစား")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                _getTextHeader(
                    "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                    Colors.red),
                _getForm("အခန်းအရေအတွက်", null, _apartmentCount),
                Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _getTextHeader(
                            "ပါဝါမီတာ အရေအတွက်", null, FontWeight.bold, 17.0),
                        _getForm("10 KW"),
                        _getForm("20 KW"),
                        _getForm("30 KW"),
                        _getTextHeader(
                            "ပါဝါမီတာ ထည့်သွင်းလျှောက်ထားလိုလျှင် မိမိလျှောက်ထားလိုသော မီတာအမျိုးအစားတွင် အရေအတွက် ထည့်သွင်းပေးပါရန်",
                            Colors.red),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: TextFormField(
                    
                    enabled: false, 
                    controller: valueTxt,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      labelText: "အိမ်သုံးမီတာ အရေအတွက်",
                    ),
                  ),
                ),
                Card(child: Column(
                  children: [
                    _getWaterCheckBox("ရေစက်မီတာ အသုံးပြုမည်",),
                      _getElevatorCheckBox("ဓါတ်လှေကားမီတာ အသုံးပြုမည်",),
                      SizedBox(height: 10,),
                 _getTextHeader(
                            "ရေစက် / ဓါတ်လှေကား ) မီတာ အသုံးပြုလိုလျှင် အမှန်ခြစ်ပေးပါရန်၊ မီတာအမျိုးအစား(KW)နှင့် အရေအတွက်ကို သက်ဆိုင်ရာမြိုနယ် လျှပ်စစ်အင်ဂျင်နီယာရုံးမှ သတ်မှတ်ပေးသွားမည် ဖြစ်ပါသည်။",
                            Colors.red),
                            SizedBox(height: 15,),
                  ],
                )),
                SizedBox(height: 15,),
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
                  
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CForm04InfoMdy()));
                      ;
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text(
                      "လုပ်ဆောင်မည်",
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(height: 20,),

              ],
            ),
             SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getForm(name, [hintTxt, value]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: value,
        onChanged: (value){
          //  String form1 = _apartmentCount.text;
          //  String form2 = _floorCount.text;
          // if(form1 != "" && form2 != ""){
          //   int valueTxtInt =  int.parse(_apartmentCount.text) * int.parse(_floorCount.text);
            valueTxt.text= _apartmentCount.text;
          // }
        },
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
          
        ),
      ),
    );
  }

  Widget _getTextHeader(txt, [color, weight, size]) {
    return Text(
      txt,
      style: TextStyle(
          color: color,
          fontFamily: "Pyidaungsu",
          fontWeight: weight,
          fontSize: size ?? size),  
      textAlign: TextAlign.center,
    );
  }
  
  Widget _getWaterCheckBox(name) {
    return CheckboxListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 13, ),
      ),
      value: checkedWaterValue,
      onChanged: (newValue) {
        setState(() {
          checkedWaterValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  Widget _getElevatorCheckBox(name) {
    return CheckboxListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 13, ),
      ),
      value: checkedElevatorValue,
      onChanged: (newValue) {
        setState(() {
          checkedElevatorValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
