import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/Pages/ApplicationForm.dart';

import './ApplicationForm.dart';

class Money extends StatefulWidget {
  const Money({Key? key}) : super(key: key);

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ကောက်ခံမည့်နှုန်းများ"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 17),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.black,
              ),
              children: [
                _getTableHeader(
                    "အကြောင်းအရာများ", "ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
                getTableBodyDetail("မီတာသတ်မှတ်ကြေး", "၈၀,၀၀၀"),
                getTableBodyDetail("အာမခံစဘော်ငွေ", "၄,၀၀၀"),
                getTableBodyDetail("လိုင်းကြိုး (ဆက်သွယ်ခ)", "၂,၀၀၀"),
                getTableBodyDetail("မီးဆက်ခ", "၂,၀၀၀"),
                getTableBodyDetail("ကြီးကြပ်ခ", "၁,၀၀၀"),
                getTableBodyDetail("မီတာလျှောက်လွှာမှတ်ပုံတင်ကြေး", "၁,၀၀၀"),
                getTableBodyDetail("စုစုပေါင်း", "၉၀,၀၀၀"),
                // TableRow(children: [
                //   ElevatedButton(onPressed: () {}, child: Text("ရွေးချယ်မည်")),
                // ])
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ApplicationForm()));
              },
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              child: Text("ရွေးချယ်မည်"),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _getTableHeader(d1, d2) {
    return TableRow(children: [
      _getTableHeaderDetail(d1),
      _getTableHeaderDetail(d2),
    ]);
  }

  Container _getTableHeaderDetail(data) {
    return Container(
      height: 65,
      child: Center(
          child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }

  Container _getTableBody(name) {
    return Container(
      height: 65,
      padding: EdgeInsets.all(14),
      child: Text(
        name,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.left,
      ),
    );
  }

  TableRow getTableBodyDetail(d1, d2) {
    return TableRow(children: [
      _getTableBody(d1),
      _getTableBody(d2),
    ]);
  }
}
