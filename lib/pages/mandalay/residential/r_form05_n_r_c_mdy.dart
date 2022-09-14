import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RForm05NRCMdy extends StatefulWidget {
  const RForm05NRCMdy({Key? key}) : super(key: key);

  @override
  State<RForm05NRCMdy> createState() => _RForm05NRCMdyState();
}

class _RForm05NRCMdyState extends State<RForm05NRCMdy> {
  int? formId;
  bool isLoading = false;
  File? frontFile;
  bool frontFileError = false;
  File? backFile;
  bool backFileError = false;
  FilePickerResult? result;
  bool edit = false;

  final subTitle = const Text(
    "လျှောက်ထားသူ၏ မှတ်ပုံတင်ဓါတ်ပုံ (မူရင်း)",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    ),
    textAlign: TextAlign.center,
  );

  final noti = const Text(
    "* ကြယ်အမှတ်အသားပါသော နေရာများကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
    style: TextStyle(color: Colors.red),
    textAlign: TextAlign.center,
  );

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
    print('form_id is $formId');
    if (data['edit'] != null) {
      setState(() {
        edit = data['edit'];
      });
    }
    return WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body: isLoading ? loading() : body(context),
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
      title: const Text("မှတ်ပုံတင်ဓါတ်ပုံ", style: TextStyle(fontSize: 18.0)),
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

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text('လုပ်ဆောင်နေပါသည်။ ခေတ္တစောင့်ဆိုင်းပေးပါ။')
      ],
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 15),
              subTitle,
              SizedBox(height: 10),
              noti,
              SizedBox(height: 13),
              fileWidget(),
              SizedBox(height: 20),
              actionButton(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget fileWidget() {
    return Column(
      children: [front(), SizedBox(height: 20), back()],
    );
  }

  Row requiredText(String label) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              '${label}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            '*',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget optionalText(label) {
    return Text(
      label,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget front() {
    return (frontFile == null)
        ? uploadWidget(
            'မှတ်ပုံတင်အရှေ့ဘက်', true, frontFileError, frontExplorer)
        : previewWidget('မှတ်ပုံတင်အရှေ့ဘက်', true, frontFile!, frontClear);
  }

  Widget back() {
    return (backFile == null)
        ? uploadWidget('မှတ်ပုံတင်အနောက်ဘက်', true, backFileError, backExplorer)
        : previewWidget('မှတ်ပုံတင်အနောက်ဘက်', true, backFile!, backClear);
  }

  Widget uploadWidget(String label, bool isRequired, bool errorState,
      VoidCallback openExployer) {
    return GestureDetector(
      onTap: openExployer,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: 320,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isRequired
                ? requiredText('$labelပုံတင်ရန်')
                : optionalText('$labelပုံတင်ရန်'),
            SizedBox(height: 20),
            Icon(
              Icons.file_upload,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'ပုံတင်ရန်နှိပ်ပါ (တစ်ပုံသာတင်နိုင်ပါသည်)',
              style:
                  TextStyle(color: errorState ? Colors.red : Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  void frontExplorer() async {
    File? file = await _openFileExplorer();
    if (file != null) {
      setState(() {
        frontFile = file;
      });
    }
  }

  void backExplorer() async {
    File? file = await _openFileExplorer();
    if (file != null) {
      setState(() {
        backFile = file;
      });
    }
  }

  dynamic _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      File file = File(result.files.single.path.toString());
      return file;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Widget previewWidget(
      String label, bool isReq, File file, VoidCallback imageClearFun) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 320,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            isReq ? requiredText(label) : optionalText(label),
            SizedBox(height: 20),
            imagePreview(file),
            imageClear(imageClearFun)
          ],
        ),
      ),
    );
  }

  Image imagePreview(File file) {
    return Image.file(
      file,
      width: double.infinity,
      height: 200,
    );
  }

  FlatButton imageClear(VoidCallback onPressedFun) {
    return FlatButton(
      onPressed: onPressedFun,
      child: Text(
        'ပုံပယ်ဖျက်မည်',
        style: TextStyle(fontSize: 12, color: Colors.redAccent),
      ),
    );
  }

  void frontClear() {
    setState(() {
      frontFile = null;
    });
  }

  void backClear() {
    setState(() {
      backFile = null;
    });
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
                primary: Colors.black12,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
            child: Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 15))),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7)),
            onPressed: () {
              if (frontFile != null && backFile != null) {
                startLoading();
                saveFile(context);
              } else {
                setState(() {
                  frontFile == null ? frontFileError = true : true;
                  backFile == null ? backFileError = true : true;
                });
              }
            },
            child: Text(
              "ဖြည့်သွင်းမည်",
              style: TextStyle(fontSize: 15),
            )),
      ],
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

  void saveFile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiPath = prefs.getString('api_path').toString();
    String token = prefs.getString('token').toString();
    var url = Uri.parse("${apiPath}api/nrc");
    try {
      var request = await http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      request.fields["token"] = token;
      request.fields["form_id"] = formId.toString();
      var pic1 = await http.MultipartFile.fromPath('front', frontFile!.path);
      request.files.add(pic1);
      var pic2 = await http.MultipartFile.fromPath('back', backFile!.path);
      request.files.add(pic2);
      var response = await request.send();

      // if (response.statusCode == 200) {
      // stopLoading();
      // print('Uploaded Success!');

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var responseMap = jsonDecode(responseString);

      if (responseMap['success'] == true) {
        stopLoading();
        refreshToken(responseMap['token']);
        goToNextPage();
      } else {
        stopLoading();
        showAlertDialog(responseMap['title'], responseMap['message'], context);
      }
      // } else {
      //   stopLoading();
      //   showAlertDialog(responseMap['title'], responseMap['message'], context);
      // }
    } on SocketException catch (e) {
      stopLoading();
      showAlertDialog('Connection timeout!',
          'Error occured while Communication with Server', context);
      print('connection error $e');
    }
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

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  void goToNextPage() async {
    if (edit) {
      goToBack();
    } else {
      final result = await Navigator.pushNamed(
          context, 'mdy_r_form06_household',
          arguments: {'form_id': formId});
      setState(() {
        formId = (result ?? 0) as int;
      });
      print('form id is $formId');
    }
  }

  void goToBack() {
    Navigator.of(context).pop(formId);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
