import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: applicationBar(),
      body: Column(
        children: [
          formWiget("စကားဝှက်အ‌သစ် ဖြည့်သွင်းပါ",newPasswordController),
          formWiget("စကားဝှက်အတည်ပြုရန်",confirmPasswordController),
          actionButton(context),
        ],
      )
    );
  }

  AppBar applicationBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("စကားဝှက်ပြင်ဆင်ခြင်း",
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

Widget formWiget(String name, TextEditingController textController,
      [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          label: Text(name),
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${name}ကို ထည့်ပါ။";
          }
        },
      ),
    );
  }

  Widget actionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              goToBack();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.black38,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
            child: Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 15))),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
            onPressed: () {
              // startLoading();
              // saveFile(context);
            },
            child: Text(
              "ပြင်ဆင်မည်",
              style: TextStyle(fontSize: 15),
            )),
      ],
    );
  }
}