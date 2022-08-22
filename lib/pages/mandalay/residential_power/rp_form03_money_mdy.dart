import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mandalay/residential_power/rp_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form04_info.dart';

class RpForm03MoneyMdy extends StatefulWidget {
  const RpForm03MoneyMdy({Key? key}) : super(key: key);

  @override
  State<RpForm03MoneyMdy> createState() => _RpForm03MoneyMdyState();
}

class _RpForm03MoneyMdyState extends State<RpForm03MoneyMdy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ကောက်ခံမည့်နှုန်းများ"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
          child: Column(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  color: Colors.black,
                ),
                children: [
                _getTableHeader(
                      "အကြောင်းအရာများ", "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)","ကောက်ခံရမည့်နှုန်းထား (ကျပ်)","ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                        _getTableHeader(
                      "အကြောင်းအရာများ", "၁၀ ကီလိုဝပ်","၂၀ ကီလိုဝပ်","၃၀ ကီလိုဝပ်"),
                  getTableBodyDetail("မီတာသတ်မှတ်ကြေး", "၈၀၀,၀၀၀","၁,၀၀၀,၀၀၀","၁,၂၀၀,၀၀၀"),
                  getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀","၄,၀၀၀","၄,၀၀၀"),
                  getTableBodyDetail("လိုင်းကြိုး (ဆက်သွယ်ခ)", "၆,၀၀၀","၆,၀၀၀","၆,၀၀၀"),
                  getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၂,၀၀၀", "၂,၀၀၀", "၂,၀၀၀"),
                   getTableBodyDetail("composit box", "၄၀,၀၀၀", "၄၀,၀၀၀", "၄၀,၀၀၀"),
                  getTableBodyDetail("စုစုပေါင်း", "၈၅၂,၀၀၀","၁,၀၅၂,၀၀၀","၁,၂၅၂,၀၀၀"),
                  _getChooseBtn(),
                  // TableRow(children: [
                  //   ElevatedButton(onPressed: () {}, child: Text("ရွေးချယ်မည်")),
                  // ])
                ],
              ),
              SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  TableRow _getTableHeader(d1, d2,d3,d4) {
    return TableRow(children: [
      _getTableHeaderDetail(d1),
      _getTableHeaderDetail(d2),
      _getTableHeaderDetail(d3),
      _getTableHeaderDetail(d4),
    ]);
  }

  Container _getTableHeaderDetail(data) {
    return Container(
      // height: 70,
      child: Center(
          child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,
      )),
    );
  }

  Container _getTableBody(name) {
    return Container(
      // height: 70,
      padding: EdgeInsets.all(14),
      child: Text(
        name,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.left,
      ),
    );
  }

  TableRow getTableBodyDetail(d1, d2,d3,d4) {
    return TableRow(children: [
      _getTableBody(d1,),
      _getTableBody(d2),
      _getTableBody(d3),
      _getTableBody(d4),
    ]);
  }
  TableRow _getChooseBtn(){
    return TableRow(
     children: [
        Text(""),
        _makeChooseBtn(),
        _makeChooseBtn(),
        _makeChooseBtn(),
             
     ]
    );
  }
  Widget _makeChooseBtn(){
    return Container(
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RpForm04InfoMdy()));
                },
                // style: OutlinedBorder(),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),),
                child: Text("ရွေးချယ်မည်",style: TextStyle(fontSize: 8),),
              ),
    );
  }
}
