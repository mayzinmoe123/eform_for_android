import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

import '../../utils/verify_resend_dialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  String? nameError, emailError, phoneError, passwordError;

  initializePrefs() async {
    try{
      // for production
      var url = Uri.parse('https://eform.moee.gov.mm/api/api_path_xOmfnoG1N7Nxgv');
      var response = await http.post(url, body: {});
      Map data = jsonDecode(response.body);
      print('data $data');

      if (data['success'] == true) {
        String apiPath = data['path'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('api_path', apiPath);
        setState(() {
          prefs.setString('api_path', apiPath);
        });
        print('main apiPath $apiPath');
      }
    }catch(e){
      print('exception for moep $e');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_path', 'https://eform.moee.gov.mm/');
      setState(() {
        prefs.setString('api_path', 'https://eform.moee.gov.mm/');
      });
      print('main apiPath https://eform.moee.gov.mm/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? loading() : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "စကားဝှက်ပြင်ဆင်ရန်",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body:  body(context),
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

  Widget errorText(String? text) {
    return Text(
      text ?? '',
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 12.0,
      ),
    );
  }

  Widget body(context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.amber[700],
                padding: EdgeInsets.all(20),
                child: Text(
                    'အီးမေးလ်လိပ်စာနေရာတွင် အကောင့်ဖွင့်ခဲ့သည့် အီးမေးလ်အားဖြည့်သွင်းပေးရပါမည်။ ၄င်းအီးမေးလ်လိပ်စာသို့ စကားဝှက်ပြောင်းလဲရန်လင့်ခ်ကို ပေးပို့ပေးမည်ဖြစ်ပါသည်။',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              emailField(),
              emailError != null ? errorText(emailError) : SizedBox(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  errorClear();
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    initializePrefs();
                    reset(context);
                  }
                },
                child: const Text(
                  "စကားဝှက်ပြောင်းလဲရန် နှိပ်ပါ။",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextFormField(
        controller: emailController,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: 'အီးမေးလ်လိပ်စာ',
          helperStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(fontSize: 14),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "အီးမေးလ်လိပ်စာထည့်ပါ";
          } else if (!EmailValidator.validate(value)) {
            return "မှန်ကန်သောအီးမေးလ်လိပ်စာထည့်ပါ";
          }
          return null;
        },
      ),
    );
  }

  void reset(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiPath = prefs.getString("api_path");
    try {
      var url = Uri.parse('${apiPath}api/reset_passwordndh&bdflRf');
      print('apiPathi $apiPath');
      var response = await http.post(url, body: {
        'email': emailController.text,
      });
      Map data = jsonDecode(response.body);
      if (data['success'] == true) {
        stopLoading();
        inputClear();
        errorClear();
        showAlertDialog(data['title'], data['message'], context);
      } else {
        stopLoading();
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      print('http error $e');
      stopLoading();
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
    }on Exception catch (e) {
      logout();
    }
  }

  void inputClear() {
    setState(() {
      emailController.text = '';
    });
  }

  void errorClear() {
    setState(() {
      emailError = null;
    });
  }

  void showVerifyDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return VerifyResendDialog(
              title, content, emailController.text, passwordController.text);
        });
  }

  void stopLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = true;
      });
    }
  }

  void showAlertDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: title != 'Unauthorized' ? Text('CLOSE') : logoutButton(),
              )
            ],
          );
        });
  }

  Widget logoutButton() {
    return GestureDetector(
      child: Text('LOG OUT'),
      onTap: () {
        logout();
      },
    );
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }
}
