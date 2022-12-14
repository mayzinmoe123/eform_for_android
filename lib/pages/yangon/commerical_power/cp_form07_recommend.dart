import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper/file_noti.dart';

class CpForm07Recommend extends StatefulWidget {
  const CpForm07Recommend({Key? key}) : super(key: key);

  @override
  State<CpForm07Recommend> createState() => _CpForm07RecommendState();
}

class _CpForm07RecommendState extends State<CpForm07Recommend> {
  int? formId;
  bool edit = false;
  bool isLoading = false;
  File? frontFile;
  bool frontFileError = false;
  File? backFile;
  bool backFileError = false;
  FilePickerResult? result;

  final subTitle = const Text(
    "လျှောက်ထားသူ၏ ထောက်ခံစာဓါတ်ပုံ(မူရင်း)",
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

  Widget fileNoti = Container(
    color: Colors.amber[700],
    padding: EdgeInsets.all(10.0),
    child: Text(
      getfileNoti(),
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    setState(() {
      formId = data['form_id'];
    });
    if(data['edit'] != null){
      setState(() {
        edit = data['edit'];
      });
    }
    print('info form_id is $formId');
    return isLoading ? loading() : WillPopScope(
      child: Scaffold(
        appBar: applicationBar(),
        body: body(context),
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
      title: const Text("ထောက်ခံစာဓါတ်ပုံ", style: TextStyle(fontSize: 18.0)),
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
              fileNoti,
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
        ? uploadWidget('နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ', true,
            frontFileError, frontExplorer)
        : previewWidget('နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ', true,
            frontFile!, frontClear);
  }

  Widget back() {
    return (backFile == null)
        ? uploadWidget('ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ', true,
            backFileError, backExplorer)
        : previewWidget('ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ', true,
            backFile!, backClear);
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 20),
        isReq ? requiredText(label) : optionalText(label),
        SizedBox(height: 20),
        imagePreview(file),
        imageClear(imageClearFun)
      ]),
    );
  }

  Image imagePreview(File file) {
    return Image.file(
      file,
      width: double.infinity,
      height: 200,
    );
  }

  TextButton imageClear(VoidCallback onPressedFun) {
    return TextButton(
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
    var url = Uri.parse("${apiPath}api/recommanded");
    try {
      var request = await http.MultipartRequest('POST', url);
      request.fields["token"] = token;
      request.fields["form_id"] = formId.toString();

      request.headers.addAll({
        'Authorization': token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      
      var pic1 = await http.MultipartFile.fromPath('front', frontFile!.path);
      request.files.add(pic1);
      var pic2 = await http.MultipartFile.fromPath('back', backFile!.path);
      request.files.add(pic2);
      var response = await request.send();

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
    } on SocketException catch (e) {
      stopLoading();
      showAlertDialog('Connection timeout!',
          'Error occured while Communication with Server', context);
      print('connection error $e');
    }on Exception catch (e) {
      logout();
    }
  }

  void stopLoading() {
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startLoading() {
    if(this.mounted){
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

  void refreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
    });
  }

  void goToNextPage() async {
     if (edit) {
      goToBack();
    }else{
  final result = await Navigator.pushNamed(
        context, '/yangon/commerical_power/cp_form08_ownership',
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
