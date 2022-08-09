import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/register.dart';
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
  SharedPreferences? prefs;

  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      prefs = sharedPreferences;
    });
    var token = prefs!.getString('token');
    if (token != null) {
      goToNextPage();
    }
  }

  Widget title() {
    return Center(
      child: Text(
        "E-Form အကောင့်ဝင်ရန်",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue,
        ),
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
        prefix: const Icon(
          Icons.person,
          size: 14.0,
        ),
        labelText: "အီးမေးလ်လိပ်စာ",
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
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          login(context, emailController.text, passwordController.text);
        }
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
      child: const Text(
        'အကောင့်ဝင်မည်',
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Pyidaungsu',
        ),
      ),
    );
  }

  InkWell registerButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Register()));
      },
      child: const Text(
        "အကောင့်မရှိပါက အကောင့်သစ်ဖွင့်ရန်",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget body() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Column(
              children: [
                logo(),
                title(),
                const SizedBox(height: 20),
                username(),
                const SizedBox(height: 20),
                password(),
                const SizedBox(height: 20),
                loginButton(context),
                const SizedBox(height: 20),
                registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? loading() : body();
  }

  login(BuildContext context, String email, String password) async {
    var apiPath = await prefs!.getString('api_path');
    if (apiPath != null) {
      var url = Uri.parse('${apiPath}api/login');
      // print('${apiPath}api/member_login');
      try {
        var response = await http.post(url, body: {
          'email': email,
          'password': password,
        });
        Map data = jsonDecode(response.body);
        if (data['success']) {
          loginSuccess(data);
        } else {
          stopLoading();
          showAlertDialog(
              'Login Invalid!', data['message'].toString(), context);
        }
      } catch (e) {
        stopLoading();
        showAlertDialog('Connection Failed!',
            'Please check your internect connection', context);
        print(e);
      }
    } else {
      stopLoading();
      showAlertDialog('Login Invalid!', 'login Path is invalid', context);
    }
  }

  void loginSuccess(data) {
    setState(() {
      prefs!.setString('token', data['token']);
    });
    goToNextPage();
  }

  void goToNextPage() {
    Navigator.pushReplacementNamed(context, '/division_choice');
  }

  void stopLoading() {
    setState(() {
      this.isLoading = false;
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
                child: Text('CLOSE'),
              )
            ],
          );
        });
  }
}
