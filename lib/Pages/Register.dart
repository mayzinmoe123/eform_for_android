import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import './DivisionChoice.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            _getForm('နာမည်'),
            _getForm('အီးမေးလ်လိပ်စာ'),
            _getForm(
                'ဖုန်းနံပါတ်', 'သင်၏မှန်ကန်သောမိုဘိုင်းဖုန်းနံပါတ်ကိုဖြည့်ပါ'),
            _getForm('စကားဝှက်', 'ကားဝှက်မှာအနည်းဆုံးစာလုံး ၆ လုံးဖြစ်ရမည်'),
            _getForm('စကားဝှက်အတည်ပြုရန်'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 17)),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/divisionChoice');
                },
                child: Text(
                  "ဖြည့်သွင်းမည်",
                  style: TextStyle(fontSize: 17),
                )),
          ],
        ),
      ),
    );
  }

  Widget _getForm(name, [hintTxt]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: name,
          helperText: hintTxt,
          helperStyle: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
