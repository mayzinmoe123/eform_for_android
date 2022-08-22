import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RForm06HouseholdMdy extends StatefulWidget {
  const RForm06HouseholdMdy({Key? key}) : super(key: key);

  @override
  State<RForm06HouseholdMdy> createState() => _RForm06HouseholdMdyState();
}

class _RForm06HouseholdMdyState extends State<RForm06HouseholdMdy> {
  int? formId;
  bool isLoading = false;
  List frontFiles = [];
  bool frontFilesError = false;
  List backFiles = [];
  bool backFilesError = false;

  final subTitle = const Text(
    "လျှောက်ထားသူ၏ အိမ်ထောင်စုစာရင်းဓါတ်ပုံ (မူရင်း)",
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
    print('info form_id is $formId');
    return Scaffold(
      appBar: applicationBar(),
      body: isLoading ? loading() : body(context),
    );
  }

  AppBar applicationBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("အိမ်ထောင်စုစာရင်းဓါတ်ပုံ",
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

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
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
              fileWidgets(),
              SizedBox(height: 20),
              actionButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget fileWidgets() {
    return Column(
      children: [front(), SizedBox(height: 20), back()],
    );
  }

  Row requiredText(String label) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${label}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '*',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget front() {
    return (frontFiles.length <= 0)
        ? multipleUploadWidget(
            'အိမ်ထောင်စုစာရင်းရှေ့ဖက်', true, frontFilesError, frontExplorer)
        : imagePreviewWidget(
            'အိမ်ထောင်စုစာရင်းရှေ့ဖက်', true, frontFiles, frontClear);
  }

  Widget back() {
    return (backFiles.length <= 0)
        ? multipleUploadWidget(
            'အိမ်ထောင်စုစာရင်းနောက်ဖက်', true, backFilesError, backExplorer)
        : imagePreviewWidget(
            'အိမ်ထောင်စုစာရင်းနောက်ဖက်', true, backFiles, backClear);
  }

  Widget multipleUploadWidget(String label, bool isRequired, bool errorState,
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
                : Text('$labelပုံတင်ရန် *'),
            SizedBox(height: 20),
            Icon(
              Icons.file_upload,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'ပုံတင်ရန်နှိပ်ပါ \n (ပုံများကို တပြိုင်နက်ထဲ ရွေးချယ်တင်နိုင်ပါသည်။)',
              style:
                  TextStyle(color: errorState ? Colors.red : Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void frontExplorer() async {
    List files = await _openFileExplorerMutiple();
    if (files.length > 0) {
      print('file upload');
      setState(() {
        frontFiles = files;
      });
    }
  }

  void backExplorer() async {
    List files = await _openFileExplorerMutiple();
    if (files.length > 0) {
      print('file upload');
      setState(() {
        backFiles = files;
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
      print('file upload');
      return file;
    } else {
      // User canceled the picker
      print('file cancel');
      return null;
    }
  }

  dynamic _openFileExplorerMutiple() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      List<File> images = result.paths.map((path) => File(path!)).toList();
      return images;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Widget imagePreviewWidget(
      String label, bool isReq, List file, VoidCallback imageClearFun) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 320,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Expanded(child: child)
          SizedBox(height: 20),
          isReq ? requiredText(label) : Text(label),
          SizedBox(height: 20),
          imagePreview(file),
          imageClear(imageClearFun)
        ]),
      ),
    );
  }

  Widget imagePreview(List files) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 3,
        // Generate 100 widgets that display their index in the List.
        children: files.map((file) => Image.file(file)).toList(),
      ),
    );
    // return Image.file(
    //   file,
    //   width: double.infinity,
    //   height: 200,
    // );
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
      frontFiles = [];
    });
  }

  void backClear() {
    setState(() {
      backFiles = [];
    });
  }

  Widget actionButton() {
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
              if (frontFiles.length > 0 && backFiles.length > 0) {
                startLoading();
                goToNextPage(formId);
                saveFile();
              } else {
                setState(() {
                  frontFiles.length <= 0
                      ? frontFilesError = true
                      : frontFilesError = false;
                  backFiles.length <= 0
                      ? backFilesError = true
                      : backFilesError = false;
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

  void saveFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiPath = prefs.getString('api_path').toString();
    String token = prefs.getString('token').toString();
    var url = Uri.parse("${apiPath}api/yangon/residential_form10");
    try {
      var request = await http.MultipartRequest('POST', url);
      request.fields["token"] = token;
      request.fields["form_id"] = formId.toString();

      List<http.MultipartFile> frontMultiFiles = [];
      for (int i = 0; i < frontFiles.length; i++) {
        var file =
            await http.MultipartFile.fromPath('front[]', frontFiles[i].path);
        frontMultiFiles.add(file);
      }
      request.files.addAll(frontMultiFiles);

      List<http.MultipartFile> backMultiFiles = [];
      for (int i = 0; i < backFiles.length; i++) {
        var file =
            await http.MultipartFile.fromPath('back[]', backFiles[i].path);
        backMultiFiles.add(file);
      }
      request.files.addAll(backMultiFiles);

      var response = await request.send();

      if (response.statusCode == 200) {
        stopLoading();
        print('Uploaded Success in household!');

        //Get the response from the server
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var responseMap = jsonDecode(responseString);

        print('http resonse $responseMap');

        if (responseMap['success'] == true) {
          stopLoading();
          var form = responseMap['form'];
          goToNextPage(form["id"]);
        } else {
          stopLoading();
          showAlertDialog(
              'Upload Failed',
              'some error occours in upload files. Please try later or connect to developer team',
              context);
        }
      } else {
        stopLoading();
        print('token $token');
        showAlertDialog('Connection Failed',
            'Please check you internet connection', context);
      }
    } catch (e) {
      print('http post error $e');
      print('token $token');
      stopLoading();
      showAlertDialog('Connection Failed',
          'Please check you internet connection http post error $e', context);
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
                child: Text('CLOSE'),
              )
            ],
          );
        });
  }

  void goToNextPage(formIdValue) async {
    final result = await Navigator.pushNamed(
        context, '/mandalay/residential/r_form07_recommend_mdy',
        arguments: {'form_id': formIdValue});
    setState(() {
      formId = (result ?? 0) as int;
    });
    print('form id is $formId');
  }

  void goToBack() {
    Navigator.of(context).pop(formId);
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/division_choice', (route) => false);
  }
}
