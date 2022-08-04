import 'dart:html';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Pages/Register.dart';
// import 'package:flutter_application_1/Pages/DivisionChoice.dart';

import './DivisionChoice.dart';
import './Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Form Login"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 170),
        child: Column(
          children: [
            Image.asset(
              "asset/images/eformLogo.png",
              width: 150,
              height: 180,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefix: Icon(Icons.person),
                labelText: "Username",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefix: Icon(Icons.lock),
                labelText: "Password",
                suffix: Icon(Icons.remove_red_eye_rounded),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/divisionChoice');
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SafeArea(
              child: SizedBox(
                height: 50,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                "အကောင့်သစ်ဖွင့်ရန်",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
