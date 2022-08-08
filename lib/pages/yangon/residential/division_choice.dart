import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/yangon/residential/meter_apply_choice.dart';

class DivisionChoice extends StatefulWidget {
  const DivisionChoice({Key? key}) : super(key: key);

  @override
  State<DivisionChoice> createState() => _DivisionChoiceState();
}

class _DivisionChoiceState extends State<DivisionChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "လျှောက်လွှာပုံစံများ",
            style: TextStyle(fontFamily: "Burmese"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Card(
                  child: ListTile(
                title: Text("ရန်ကုန်တိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း",
                    style: TextStyle(fontFamily: "Burmese")),
                leading: Icon(Icons.map),
                trailing: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MeterApplyChoice()));
                    },
                    child: Icon(Icons.arrow_circle_right)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              )),
              SizedBox(
                height: 8,
              ),
              Card(
                  child: ListTile(
                title: Text("မန္တလေးတိုင်းဒေသကြီးတွင် မီတာလျှောက်ထားခြင်း",
                    style: TextStyle(fontFamily: "Burmese")),
                leading: Icon(Icons.map),
                trailing: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MeterApplyChoice()));
                    },
                    child: Icon(Icons.arrow_circle_right)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              )),
              SizedBox(
                height: 8,
              ),
              Card(
                  child: ListTile(
                title: Text(
                    "အခြားတိုင်းဒေသကြီး/ပြည်နယ်များတွင် မီတာလျှောက်ထားခြင်း",
                    style: TextStyle(fontFamily: "Burmese")),
                leading: Icon(Icons.map),
                trailing: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MeterApplyChoice()));
                    },
                    child: Icon(Icons.arrow_circle_right)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              )),
            ],
          ),
        ));
  }
}
