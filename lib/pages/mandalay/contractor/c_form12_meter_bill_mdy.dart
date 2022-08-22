import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form12_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form13_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/meter_apply_choice%20mdy.dart';



class CForm12MeterBillMdy extends StatefulWidget {
  const CForm12MeterBillMdy({Key? key}) : super(key: key);

  @override
  State<CForm12MeterBillMdy> createState() =>
      _CForm12MeterBillMdyState();
}

class _CForm12MeterBillMdyState extends State<CForm12MeterBillMdy> {
  PlatformFile? file;
  PlatformFile? file2;
  FilePickerResult? result;
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("(မီတာ/ယာယီမီတာ) ချလံ ပုံတင်ရန် (မူရင်း) ",style: TextStyle(fontFamily: "Pyidaungsu"),),
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
                    fontFamily: "Pyidaungsu"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "နောက်ဆုံးပေးဆောင်ထားသော (မီတာ/ယာယီမီတာ) ချလံ ပုံတင်ရန် (မူရင်း)  ***",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: "Pyidaungsu"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
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
                      child: Text("ဓာတ်ပုံ‌ရွေးချယ်ရန်"),
                    ),
                    (file?.path == null)
                        ? Card()
                        : Card(
                          child: Image.file(
                              File(file!.path.toString()),
                              width: mSize.width,
                              height: 200,
                            ),
                        ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                 SizedBox(height: 20,),
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
                            Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 13,fontFamily: "Pyidaungsu"))),
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
                                MeterApplyChoiceMdy()));
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


  // void viewfile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
}
