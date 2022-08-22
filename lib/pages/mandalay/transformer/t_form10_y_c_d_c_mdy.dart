import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/pages/yangon/commerical_power/cp_form12_farm_land.dart';
import 'package:flutter_application_1/pages/yangon/contractor/c_form12_meter_bill.dart';
import 'package:flutter_application_1/pages/yangon/meter_apply_choice%20mdy.dart';
import 'package:flutter_application_1/pages/yangon/transformer/t_form11_farm_land.dart';



class TForm10YCDCMdy extends StatefulWidget {
  const TForm10YCDCMdy({Key? key}) : super(key: key);

  @override
  State<TForm10YCDCMdy> createState() =>
      _TForm10YCDCMdyState();
}

class _TForm10YCDCMdyState extends State<TForm10YCDCMdy> {
  PlatformFile? file;
  PlatformFile? file2;
  FilePickerResult? result;
  var imageFiles = [];
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("စည်ပင်ထောက်ခံစာ ပုံတင်ရန်(မူရင်း) ",style: TextStyle(fontFamily: "Pyidaungsu"),),
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
                  "စည်ပင်ထောက်ခံစာ ပုံတင်ရန်(မူရင်း)",
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
                    Text("စည်ပင်ထောက်ခံစာ ပုံတင်ရန်(မူရင်း)   ***"),
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
                SizedBox(
                  height: 10,
                ),
                  Container(
                  width: mSize.width,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.redAccent),
                   child: Text(
                    "* အလင်းရောင်သုံး ထရန်ဖော်မာဖြစ်ပါက ဆက်လက်လုပ်ဆောင်မည် ကိုနှိပ်ပါ။",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Pyidaungsu",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                ),
                 ),
                 SizedBox(
                  height: 10,
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
                  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),primary: Colors.purpleAccent),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MeterApplyChoiceMdy()));
                        },
                        child: Text(
                          "ဆက်လက်လုပ်ဆောင်မည်",
                          style: TextStyle(fontSize: 15,fontFamily: "Pyidaungsu"),
                        )),
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
