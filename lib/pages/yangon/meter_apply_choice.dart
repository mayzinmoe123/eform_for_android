import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/division_choice.dart';
import 'package:flutter_application_1/pages/yangon/residential/rules_and_regulation.dart';

class MeterApplyChoice extends StatefulWidget {
  const MeterApplyChoice({Key? key}) : super(key: key);

  @override
  State<MeterApplyChoice> createState() => _MeterApplyChoiceState();
}

class _MeterApplyChoiceState extends State<MeterApplyChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "မီတာလျှောက်ထားခြင်း",
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      body: Column(
        children: [
          _getMeterlist("အိမ်သုံးမီတာ လျှောက်ထားခြင်း", Icons.home,
              RulesAndRegulations()),
          _getMeterlist("အိမ်သုံးပါဝါမီတာ လျှောက်ထားခြင်း",
              Icons.electric_meter, DivisionChoice()),
          _getMeterlist("စက်မှုသုံးပါဝါမီတာ လျှောက်ထားခြင်း",
              Icons.construction, Login()),
          _getMeterlist("ကန်ထရိုက်တိုက် မီတာလျှောက်ထားခြင်း",
              Icons.business_center, Login()),
          _getMeterlist("အိမ်သုံးထရန်စဖော်မာ လျှောက်ထားခြင်း",
              Icons.flash_on_outlined, Login()),
          _getMeterlist("လုပ်ငန်းသုံးထရန်စဖော်မာ လျှောက်ထားခြင်း",
              Icons.flash_on_outlined, Login()),
          _getMeterlist("ကျေးရွာမီးလင်းရေ", Icons.lightbulb_circle, Login()),
        ],
      ),
    );
  }

  Widget _getMeterlist(String name, IconData icon, page) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(name, style: TextStyle(fontSize: 14.0)),
        leading: Icon(
          icon,
          size: 14.0,
        ),
        trailing: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => page)));
          },
          child: Icon(Icons.double_arrow, size: 14.0),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ));
  }
}
