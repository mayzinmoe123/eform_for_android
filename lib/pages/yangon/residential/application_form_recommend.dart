import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'application_form_household.dart';
import 'application_form_owership.dart';

class ApplicationFormRecommend extends StatefulWidget {
  const ApplicationFormRecommend({Key? key}) : super(key: key);

  @override
  State<ApplicationFormRecommend> createState() =>
      _ApplicationFormRecommendState();
}

class _ApplicationFormRecommendState extends State<ApplicationFormRecommend> {
  PlatformFile? file;
  PlatformFile? file2;
  FilePickerResult? result;
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("လျှောက်ထားသူ၏ ထောက်ခံစာဓါတ်ပုံ(မူရင်း)",style: TextStyle(fontFamily: "Burmese"),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း)",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: "Burmese"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "Burmese"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer();
                      },
                      child: Text("နေထိုင်မှုမှန်ကန်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း) ***"),
                    ),
                    (file?.path == null)
                        ? Container()
                        : Image.file(
                            File(file!.path.toString()),
                            width: mSize.width,
                            height: 200,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer2();
                      },
                      child: Text("ကျူးကျော်မဟုတ်ကြောင်း ရပ်ကွက်ထောက်ခံစာ (မူရင်း) ***"),
                    ),
                    (file2?.path == null)
                        ? Container()
                        : Image.file(
                            File(file2!.path.toString()),
                            width: mSize.width,
                            height: 200,
                          )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black12,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7)),
                        child:
                            Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 13,fontFamily: "Burmese"))),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ApplicationFormOwnership()));
                        },
                        child: Text(
                          "ဖြည့်သွင်းမည်",
                          style: TextStyle(fontSize: 13),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
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

  void _openFileExplorer() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result == null) return;

    // Do something with the file

    file = result!.files.first;
    print(file);

    // viewfile(file);
    setState(() {});
  }

  void _openFileExplorer2() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result == null) return;

    // Do something with the file

    file2 = result!.files.first;
    // var filename = file;
    // print("${file}");

    // viewfile(file);
    setState(() {});
  }

  // void viewfile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
}
