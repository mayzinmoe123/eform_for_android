import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mandalay/transformer/t_form04_info_mdy.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form04_info.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form04_info.dart';

import '../../../utils/helper/num_translate.dart';
// import 'package:flutter_application_1/utils/helper/num_translate.dart';

class TForm03MoneyMdy extends StatefulWidget {
  const TForm03MoneyMdy({Key? key}) : super(key: key);

  @override
  State<TForm03MoneyMdy> createState() => _TForm03MoneyMdyState();
}


class _TForm03MoneyMdyState extends State<TForm03MoneyMdy> {
  int selectedValue = 0; 
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
              Card(child: Column(
                children: [
                  Text("တိုင်အမျိုးအစား",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                   Row(
                children: [
                 Expanded(
                   child: RadioListTile(
          // Visual Density passed here
          visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 0, groupValue: selectedValue,title: Text("တစ်တိုင်"), onChanged: ((value) {
                     setState(() {
                       selectedValue =0;
                     });
                   })),
                 ),
                  Expanded(
                   child: RadioListTile(visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 1, groupValue: selectedValue,title: Text("နှစ်တိုင်"), onChanged: ((value) {
                     setState(() {
                       selectedValue =1;
                     });
                   })),
                 ),
                  Expanded(
                   child: RadioListTile(visualDensity: const VisualDensity(horizontal: -4.0),
          dense: true,value: 2, groupValue: selectedValue,title: Text("တိုင်များ"), onChanged: ((value) {
                     setState(() {
                       selectedValue =2;
                     });
                   })),
                 ),
                ],
              ),
               
                ],
              )),
             
            
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildCells(28),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildRows(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 60.0,
        height: 80.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Text(replaceFarsiNumber("${index == 0 || index == -1 || index == 1 ? '' : (index++)-1}"),
            style: TextStyle(fontSize: 16)),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
        count,
        (index) => SingleChildScrollView(
              child: Column(
                children: [
                  _getDetailDataHeader2("အကြောင်းအရာများ", "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                   _getDetailDataHeader("အမျိုးအစား (ကေဗွီအေ)", "မီတာသတ်မှတ်ကြေး", "အာမခံစဘော်ငွေ", "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                      "မီးဆက်ခ", "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး","တည်ဆောက်စရိတ်", "စုစုပေါင်း"),
                  _getDetailData("၅၀", "၁,၈၀၀,၀၀၀/-", "၃၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၂,၁၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀", "၂,၁၀၀,၀၀၀/-", "၆၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၂,၇၃၅,၅၀၀/-"),
                  _getDetailData("၁၆၀", "၂,၄၀၀,၀၀၀/-", "၉၆၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၃,၇၉၅,၅၀၀/-"),
                  _getDetailData("၂၀၀", "၂,၇၀၀,၀၀၀/-", "၁,၂၀၇,၅၀၀/-	", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၄,၃၃၅,၅၀၀/-"),
                  _getDetailData("၂၅၀", "၃,၀၀၀,၀၀၀/-", "၁,၅၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၄,၉၃၅,၅၀၀/-"),
                  _getDetailData("၃၁၅", "၃,၃၀၀,၀၀၀/-", "၁,၈၉၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၅,၆၂၅,၅၀၀/-"),
                  _getDetailData("၄၀၀", "၃,၉၀၀,၀၀၀/-", "၂,၄၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၄၀၀,၀၀၀/-", "၆,၇၃၅,၅၀၀/-"),
                  _getDetailData("၅၀၀", "၄,၅၀၀,၀၀၀/-", "၃,၀၀၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၈,၀၃၅,၅၀၀/-"),
                  _getDetailData("၆၃၀", "၅,၈၀၀,၀၀၀/-", "၃,၇၈၇,၅၀၀/-", "၆,၀၀၀/-",
                      "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၁၀,၁၁၅,၅၀၀/-"),
                  _getDetailData("၇၅၀", "၆,၃၀၀,၀၀၀/-", "၄,၅၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၁၁,၃၃၅,၅၀၀/-"),
                  _getDetailData("၈၀၀", "၆,၈၀၀,၀၀၀/-	", "၄,၈၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၁၂,၁၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀၀", "၇,၈၀၀,၀၀၀/-", "၆,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၁၄,၃၃၅,၅၀၀/-"),
                  _getDetailData("၁၂၅၀", "၉,၃၀၀,၀၀၀/-", "၇,၅၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၁,၀၀၀,၀၀၀/-", "၁၇,၈၃၅,၅၀၀/-"),
                  _getDetailData("၁၅၀၀", "၁၈,၀၀၀,၀၀၀/-", "၉,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၁,၀၀၀,၀၀၀/-", "၂၈,၀၃၅,၅၀၀/-"),
                  _getDetailData("၃၀၀၀", "၂၅,၀၀၀,၀၀၀/-", "၁၈,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၁,၂၀၀,၀၀၀/-", "၄၄,၂၃၅,၅၀၀/-"),
                  _getDetailData("၅၀၀၀", "၅၀,၀၀၀,၀၀၀/-", "၃၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၁,၆၀၀,၀၀၀/-", "၈၁,၆၃၅,၅၀၀/-"),
                  _getDetailData("၁၀၀၀၀", "၁၀၀,၀၀၀,၀၀၀/-", "၆၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၁,၆၀၀,၀၀၀/-", "၁၆၁,၆၃၅,၅၀၀/-"),
                  _getDetailData("၂၀၀၀၀", "၂၀၀,၀၀၀,၀၀၀/-", "၁၂၀,၀၀၇,၅၀၀/-",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၂၅,၀၀၀,၀၀၀/-", "၃၄၅,၀၃၅,၅၀၀/-"),
                  _getDetailData("၂၅၀၀၀", "၂၅၀,၀၀၀,၀၀၀/-", "၁၅၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၃၀,၀၀၀,၀၀၀/-", "၄၃၀,၀၃၅,၅၀၀/-"),
                  _getDetailData("၃၀၀၀၀", "၃၀၀,၀၀၀,၀၀၀/-", "၁၈၀,၀၀၇,၅၀၀/-	",
                      "၆,၀၀၀/-", "၂,၀၀၀/-", "၂၀,၀၀၀/-","၅၀၀,၀၀၀/-", "၄၈၀,၀၃၅,၅၀၀/-"),
                ],
              ),
            ));
  }

  List<Widget> _buildHeaderRows(int count) {
    return List.generate(
        count,
        (index) => SingleChildScrollView(
              child: Column(
                children: [
                  _getDetailDataHeader2("အကြောင်းအရာများ", "၁၁/၀.၄ ကေဗွီ ထရန်စဖော်မာ Rating အလိုက် ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                  _getDetailData("အမျိုးအစား (ကေဗွီအေ)", "မီတာသတ်မှတ်ကြေး", "အာမခံစဘော်ငွေ", "လိုင်းကြိုး (ဆက်သွယ်ခ)",
                      "မီးဆက်ခ", "မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး","တည်ဆောက်စရိတ်", "စုစုပေါင်း"),
                ],
              ),
            ));
  }

   

  Widget _getDetailData(d1, d2, d3, d4, d5, d6, d7,d8) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableBody(d2),
          _getTableBody(d3),
          _getTableBody(d4),
          _getTableBody(d5),
          _getTableBody(d6),
          _getTableBody(d7),
          _getTableBody(d8),
          _makeChooseBtn(),
        ],
      ),
    );
  }

   Widget _getDetailDataHeader(d1, d2, d3, d4, d5, d6, d7,d8) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableBody(d2),
          _getTableBody(d3),
          _getTableBody(d4),
          _getTableBody(d5),
          _getTableBody(d6),
          _getTableBody(d7),
          _getTableBody(d8),
        ],
      ),
    );
  }
  Widget _getDetailDataHeader2(d1, d2) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      // width: MediaQuery.of(context).size.width,
      width: 950,
      height: 80.0,
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: [
          _getTableBody(d1),
          _getTableHeader(d2),
        ],
      ),
    );
  }

  Container _getTableHeader(name) {
    return Container(
      // height: 70,
      width: 800,
      padding: EdgeInsets.all(20),
       decoration: BoxDecoration(
    border: Border.all(color: Colors.black38)
  ),
      child: Text(
        name,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
  Container _getTableBody(name) {
    return Container(
      // height: 70,
      width: 120,
      padding: EdgeInsets.all(14),
      child: Text(
        name,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow getTableBodyDetail(d1, d2, d3, d4) {
    return TableRow(children: [
      _getTableBody(d1),
      _getTableBody(d2),
      _getTableBody(d3),
      _getTableBody(d4),
    ]);
  }

  TableRow _getChooseBtn() {
    return TableRow(children: [
      Text(""),
      _makeChooseBtn(),
      _makeChooseBtn(),
      _makeChooseBtn(),
    ]);
  }

  Widget _makeChooseBtn() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(14),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TForm04InfoMdy()));
        },
        // style: OutlinedBorder(),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Text(
          "ရွေးချယ်မည်",
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  
}
