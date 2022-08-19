import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/account_header.dart';
import 'package:flutter_application_1/utils/account_link.dart';

class AccountSetting extends StatelessWidget {
  final String name;
  final String email;
  const AccountSetting(this.name, this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              AccountHeader(name, email),
              AccountLink(Icons.person_outline, 'မိမိအကောင့်', goToAccountInfo),
              AccountLink(
                  Icons.key_outlined, 'စကားဝှက်ပြောင်းလဲရန်', goToAccountInfo),
              AccountLink(Icons.exit_to_app_outlined, 'အကောင့်မှထွက်မည်',
                  goToAccountInfo),
            ]),
          )
        ],
      ),
    );
  }

  void goToAccountInfo() {}
}
