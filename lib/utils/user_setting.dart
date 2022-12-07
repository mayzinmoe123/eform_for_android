import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: applicationBar(),
        body:   Column(
          children: [
            Expanded(
              child: ListView(children: [
                settingWidget(
                    Icons.phone, 'ဖုန်းနံပါတ် ပြင်ဆင်ရန်', phone),
                settingWidget(
                    Icons.email, 'အီးမေးပြင်ဆင်ရန်', email),
                settingWidget(Icons.password_rounded, 'စကားဝှက် ပြင်ဆင်ရန်', password),
                settingWidget(
                    Icons.language, 'ဘာသာစကား', lang),
              ]),
            )
          ],
        ),
      );
  }

  Widget settingWidget(icon, text, _onTap) {
    var msize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            splashColor: Colors.lightBlueAccent,
            onTap: _onTap,
            child: Container(
              width: msize.width,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        icon,
                        color: Colors.black38,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(text),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black45,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 AppBar applicationBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("အသုံးပြုသူအကောင့်ဆိုင်ရာ",
          style: TextStyle(fontSize: 18.0)),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          goToBack();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            goToHomePage(context);
          },
          icon: const Icon(
            Icons.home,
            size: 18.0,
          ),
        ),
      ],
    );
  }

  void goToBack() {
    Navigator.of(context).pop();
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }

  void lang() {
    Navigator.pushNamed(
        context, '/user_setting');
  }

  void phone() {
     Navigator.pushNamed(
        context, '/phone_change');
  }

  void email() {
     Navigator.pushNamed(
        context, '/email_change');
  }

  void password() {
     Navigator.pushNamed(
        context, '/password_confirm');
  }

  
}
