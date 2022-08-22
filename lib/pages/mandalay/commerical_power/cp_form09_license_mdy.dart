import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/pages/mandalay/commerical_power/cp_form10_y_c_d_c_mdy.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form10_power.dart';



class CpForm09LicenseMdy extends StatefulWidget {
  const CpForm09LicenseMdy({Key? key}) : super(key: key);

  @override
  State<CpForm09LicenseMdy> createState() => _CpForm09LicenseMdyState();
}

class _CpForm09LicenseMdyState extends State<CpForm09LicenseMdy> {
   var imageFiles = [];

  // FilePickerResult? result;
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း)",style: TextStyle(fontFamily: "Pyidaungsu"),),
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
                  "လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း) ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: "Pyidaungsu",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                  style: TextStyle(
                    fontFamily: "Pyidaungsu",
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 13,
                ),
                Column(
                  children: [
                    Text("လုပ်ငန်းလိုင်စင်(သက်တမ်းရှိ/မူရင်း) ***"),
                    ElevatedButton(
                      onPressed: () {
                        _openFileExplorer();
                      },
                      child: Text("ဓာတ်ပုံ‌ရွေးချယ်ရန်",style: TextStyle(fontFamily: "Pyidaungsu"),),
                    ),  
                    Text("ပုံများကို တပြိုင်နက်ထဲ ရွေးချယ်တင်နိုင်ပါသည်။",style: TextStyle(fontFamily: "Pyidaungsu",color: Colors.red,fontSize: 10)),
                    Card(child: _getImage()),
                    SizedBox(
                      height: 20,
                    ), 
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
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
                            Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 15,fontFamily: "Pyidaungsu"),)),
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
                                  CpForm10YCDCMdy()));
                        },
                        child: Text(
                          "ဖြည့်သွင်းမည်",
                          style: TextStyle(fontSize: 15,fontFamily: "Pyidaungsu"),
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

  Widget _getImage() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            // childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            // crossAxisSpacing: 10,
            children: imageFiles
                .map((file) => Image.file(
                      file,
                      width: 100,
                      height: 100,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
 
  void _openFileExplorer() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom,allowedExtensions: ['jpg', 'png', 'jpeg'],);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        imageFiles = files;
        // _getImage(mSize, imageFiles);
        // print(_fileText);

        // print(imageFiles);
      });
    } else {
      // User canceled the picker
    }
  }
}