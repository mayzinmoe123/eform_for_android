import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
// import 'package:open_file/open_file.dart';

class ApplicationFormNRC extends StatefulWidget {
  const ApplicationFormNRC({Key? key}) : super(key: key);

  @override
  State<ApplicationFormNRC> createState() => _ApplicationFormNRCState();
}

class _ApplicationFormNRCState extends State<ApplicationFormNRC> {
  PlatformFile? file;
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("လျှောက်ထားသူ၏ မှတ်ပုံတင်ဓါတ်ပုံ (မူရင်း)"),
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
                        _openFileExplorer();
                      },
                      child: Text("မှတ်ပုံတင်ရှေ့ဖက် (မူရင်း) ***"),
                    ),
                    (file?.path == null)
                        ? Container()
                        : Image.file(
                            File(file!.path.toString()),
                            width: 300,
                            height: 200,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer();
                      },
                      child: Text("မှတ်ပုံတင်နောက်ဖက် (မူရင်း) ***"),
                    ),
                    (file?.path == null)
                        ? Container()
                        : Image.file(
                            File(file!.path.toString()),
                            width: 300,
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
                        style:
                            ElevatedButton.styleFrom(primary: Colors.black12),
                        child: Text("မပြုလုပ်ပါ")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Text("ဖြည့်သွင်းမည်")),
                  ],
                )
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
      allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
    );
    if (result == null) return;

    // Do something with the file

    file = result!.files.first;

    // viewfile(file);
    setState(() {});
  }

  void viewfile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
