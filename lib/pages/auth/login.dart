import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget title() {
    return Center(
      child: Column(
        children: [
          Text(
            "လျှပ်စစ်စွမ်းအားဝန်ကြီးဌာန",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.yellow[800],
            ),
          ),
          SizedBox(height: 5),
          Text(
            "E-Form သုံးစွဲသူအကောင့်ဝင်ရန်",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      "asset/images/eformLogo.png",
      width: 100,
      height: 100,
    );
  }

  TextFormField username() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        isDense: true,
        prefix: const Icon(
          Icons.person,
          size: 14.0,
        ),
        label: Text("အီးမေးလ်လိပ်စာ"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
      style: const TextStyle(
        fontSize: 14.0,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "အီးမေးလ်လိပ်စာထည့်ပါ";
        } else if (!EmailValidator.validate(value)) {
          return "မှန်ကန်သောအီးမေးလ်လိပ်စာထည့်ပါ";
        }
        return null;
      },
    );
  }

  bool hidePassword = true;
  Icon noVisibleIcon = const Icon(
    Icons.visibility_off,
    size: 14.0,
  );
  Icon visibleIcon = const Icon(
    Icons.visibility,
    size: 14.0,
  );
  TextFormField password() {
    return TextFormField(
      controller: passwordController,
      obscureText: hidePassword,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        isDense: true,
        prefix: Icon(
          Icons.lock,
          size: 14.0,
        ),
        labelText: "စကားဝှက်",
        suffixIcon: IconButton(
          icon: hidePassword ? noVisibleIcon : visibleIcon,
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
      style: TextStyle(
        fontSize: 14.0,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'စကားဝှက်ထည့်ပါ';
        }
        return null;
      },
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          login(context, emailController.text, passwordController.text);
        }
      },
      child: const Text(
        'အကောင့်ဝင်မည်',
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Pyidaungsu',
        ),
      ),
    );
  }

  ElevatedButton registerButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(), primary: Colors.orange),
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          startLoading();
          login(context, emailController.text, passwordController.text);
        }
      },
      child: const Text(
        'အကောင့်သစ်ဖွင့်မည်',
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Pyidaungsu',
        ),
      ),
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 10),
        Text('လုပ်ဆောင်နေပါသည်။ ခေတ္တစောင့်ဆိုင်းပေးပါ။')
      ],
    );
  }

  Widget body() {
    return Center(
      child: Form(
        key: _loginFormKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          shrinkWrap: true,
          children: [
            logo(),
            const SizedBox(height: 10),
            title(),
            const SizedBox(height: 20),
            username(),
            const SizedBox(height: 20),
            password(),
            const SizedBox(height: 20),
            loginButton(context),
            registerButton(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? loading() : body(),
    );
  }

  login(BuildContext context, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiPath = prefs.getString("api_path");
    try {
      var url = Uri.parse('${apiPath}api/login');
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      Map data = jsonDecode(response.body);
      if (data['success'] == true) {
        stopLoading();
        loginSuccess(data);
      } else {
        stopLoading();
        // print('data is $data');
        showAlertDialog(data['title'], data['message'], context);
      }
    } on SocketException catch (e) {
      print('http error $e');
      stopLoading();
      showAlertDialog(
          'Connection timeout!',
          'Error occured while Communication with Server. Check your internet connection',
          context);
    }
  }

  void loginSuccess(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', data['token']);
      prefs.setString('user_id', data['user']['id'].toString());
      prefs.setString('user_name', data['user']['name'].toString());
      prefs.setString('user_email', data['user']['email'].toString());
    });
    goToNextPage();
  }

  void goToNextPage() {
    Navigator.pushReplacementNamed(context, '/division_choice');
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void showAlertDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
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
        context, '/', (Route<dynamic> route) => false);
  }
}
