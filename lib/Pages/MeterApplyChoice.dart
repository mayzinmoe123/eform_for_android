import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1/Pages/RulesAndRegulation.dart';

import './DivisionChoice.dart';
import './Login.dart';
import './RulesAndRegulation.dart';

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
        title: Text("မီတာလျှောက်ထားခြင်း"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
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

  Widget _getMeterlist(name, icon, page) {
    return Card(
        child: ListTile(
      title: Text(name, style: TextStyle(fontFamily: "Burmese")),
      leading: Icon(icon),
      trailing: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => page)));
          },
          child: Icon(Icons.arrow_right_alt_outlined)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ));
  }
}
