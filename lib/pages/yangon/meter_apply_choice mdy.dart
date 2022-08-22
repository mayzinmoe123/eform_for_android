import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/division_choice.dart';
import 'package:flutter_application_1/pages/mandalay/residential/r_form01_rules_mdy.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/commerical_transformer/ct_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form01_rules.dart';
// import 'package:flutter_application_1/pages/yangon/residential/rules_and_regulation.dart';
import 'package:flutter_application_1/pages/yangon/residential_power/rp_form01_rules.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form01_rules.dart';

class MeterApplyChoiceMdy extends StatefulWidget {
  const MeterApplyChoiceMdy({Key? key}) : super(key: key);

  @override
  State<MeterApplyChoiceMdy> createState() => _MeterApplyChoiceMdyState();
}

class _MeterApplyChoiceMdyState extends State<MeterApplyChoiceMdy> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getMeterlist("အိမ်သုံးမီတာ လျှောက်ထားခြင်း", Icons.home,
                RForm01RulesMdy()),
            _getMeterlist("အိမ်သုံးပါဝါမီတာ လျှောက်ထားခြင်း",
                Icons.electric_meter, RpForm01Rules()),
            _getMeterlist("စက်မှုသုံးပါဝါမီတာ လျှောက်ထားခြင်း",
                Icons.construction, CpForm01Rules()),
            _getMeterlist("ကန်ထရိုက်တိုက် မီတာလျှောက်ထားခြင်း",
                Icons.business_center, CForm01Rules()),
            _getMeterlist("အိမ်သုံးထရန်စဖော်မာ လျှောက်ထားခြင်း",
                Icons.flash_on_outlined, TForm01Rules()),
            _getMeterlist("လုပ်ငန်းသုံးထရန်စဖော်မာ လျှောက်ထားခြင်း",
                Icons.flash_on_outlined, CtForm01Rules()),
            _getMeterlist("ကျေးရွာမီးလင်းရေ", Icons.lightbulb_circle, MeterApplyChoiceMdy()),
          ],
        ),
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
