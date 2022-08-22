import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/yangon/meter_apply_choice%20mdy.dart';



class CpForm11GovAllowMdy extends StatefulWidget {
  const CpForm11GovAllowMdy({Key? key}) : super(key: key);

  @override
  State<CpForm11GovAllowMdy> createState() =>
      _CpForm11GovAllowMdyState();
}

class _CpForm11GovAllowMdyState extends State<CpForm11GovAllowMdy> {
  PlatformFile? file;
  PlatformFile? file2;
  FilePickerResult? result;
  var imageFiles = [];
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("သက်ဆိုင်ရာဝန်ကြီးဌာန ခွင့်ပြုမိန့်ဓါတ်ပုံ ",style: TextStyle(fontFamily: "Pyidaungsu"),),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "သက်ဆိုင်ရာဝန်ကြီးဌာန ခွင့်ပြုမိန့်",
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
                    Text("သက်ဆိုင်ရာဝန်ကြီးဌာန ခွင့်ပြုမိန့်ဓါတ်ပုံ"),
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
