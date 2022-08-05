import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// import 'package:open_file/open_file.dart';

class ApplicationFormHousehold extends StatefulWidget {
  const ApplicationFormHousehold({Key? key}) : super(key: key);

  @override
  State<ApplicationFormHousehold> createState() =>
      _ApplicationFormHouseholdState();
}

class _ApplicationFormHouseholdState extends State<ApplicationFormHousehold> {
  // PlatformFile? file;
  var imageFiles = [];
  var imageFiles2 = [];

  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("လျှောက်ထားသူ၏ အိမ်ထောင်စုစာရင်းဓါတ်ပုံ (မူရင်း)"),
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
                  "လျှောက်ထားသူ၏ အိမ်ထောင်စုစာရင်းဓါတ်ပုံ (မူရင်း)",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                  style: TextStyle(
                    color: Colors.red,
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
                        _openFileExplorer(mSize);
                      },
                      child: Text("အိမ်ထောင်စုစာရင်းရှေ့ဖက် (မူရင်း) ***"),
                    ),
                    // _getImage(mSize),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer2();
                      },
                      child: Text("အိမ်ထောင်စုစာရင်းနောက်ဖက် (မူရင်း) ***"),
                    ),
                    _getImage2(mSize),
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
                            Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 15))),
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
                                  ApplicationFormHousehold()));
                        },
                        child: Text(
                          "ဖြည့်သွင်းမည်",
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
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

  Widget _getImage(mSize, aa) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          // childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          // crossAxisSpacing: 10,
          children: aa
              .map((file) => Image.file(
                    file,
                    width: 100,
                    height: 100,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _getImage2(
    mSize,
  ) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          // childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          // crossAxisCount: 2,
          children: imageFiles2
              .map((file) => Image.file(
                    file,
                    width: 100,
                    height: 100,
                  ))
              .toList(),
        ),
      ),
    );
  }
  // void _openFileExplorer() async {
  //   file2 = files.toString();
  //   result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
  //   );
  //   if (result == null) return;

  //   // Do something with the file

  //   file = result!.files.first;
  //   print(file);

  //   // viewfile(file);
  //   setState(() {});
  // }

  void _openFileExplorer(mSize) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        imageFiles = files;
        // _getImage(mSize, imageFiles);
        // print(_fileText);
      });
    } else {
      // User canceled the picker
    }
  }

  void _openFileExplorer2() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        imageFiles2 = files;

        // print(_fileText);
      });
    } else {
      // User canceled the picker
    }
  }

  // void viewfile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
}
