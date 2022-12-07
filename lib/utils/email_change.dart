import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmailChange extends StatefulWidget {
  const EmailChange({super.key});

  @override
  State<EmailChange> createState() => _EmailChangeState();
}

class _EmailChangeState extends State<EmailChange> {
  int? formId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
     return isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body:  Column(
        children: [
          formWiget("အီးမေးလိပ်စာအသစ် ဖြည့်သွင်းရန်",emailController),
          actionButton(context),
        ],
      ),
      ),
      onWillPop: () async {
        goToBack();
        return true;
      },
    );
  }

  AppBar applicationBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("အီးမေးအကောင့်ပြင်ဆင်ခြင်း",
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
    Navigator.of(context).pop(formId);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }

Widget formWiget(String name, TextEditingController textController,
      [hintTxt]) {
        
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 20),
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

   Widget loading() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            Text('လုပ်ဆောင်နေပါသည်။ ခေတ္တစောင့်ဆိုင်းပေးပါ။')
          ],
        ),
      ),
    );
  }

}