import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'application_form_farm_land.dart';
import 'application_form_power.dart';

class ApplicationFormBuilding extends StatefulWidget {
  const ApplicationFormBuilding({Key? key}) : super(key: key);

  @override
  State<ApplicationFormBuilding> createState() => _ApplicationFormBuildingState();
}

class _ApplicationFormBuildingState extends State<ApplicationFormBuilding> {
   var imageFiles = [];

  // FilePickerResult? result;
  @override
 Widget build(BuildContext context) {
    var mSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("လျှောက်ထားသူ၏ အဆောက်အဦးဓါတ်ပုံ",style: TextStyle(fontFamily: "Burmese"),),
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
                  "အဆောက်အဦးဓါတ်ပုံ ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: "Burmese",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "***ကြယ်အမှတ်အသားပါသော ကွက်လပ်များကို မဖြစ်မနေ ဖြည့်သွင်းပေးပါရန်!",
                  style: TextStyle(
                    fontFamily: "Burmese",
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
                      child: Text("အဆောက်အဦးဓါတ်ပုံ  ***",style: TextStyle(fontFamily: "Burmese"),),
                    ),  
                    Text("ပုံများကို တပြိုင်နက်ထဲ ရွေးချယ်တင်နိုင်ပါသည်။",style: TextStyle(fontFamily: "Burmese",color: Colors.red,fontSize: 10)),
                    _getImage(),
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
                            Text("မပြုလုပ်ပါ", style: TextStyle(fontSize: 15,fontFamily: "Burmese"),)),
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
                                  ApplicationFormPower()));
                        },
                        child: Text(
                          "ဖြည့်သွင်းမည်",
                          style: TextStyle(fontSize: 15,fontFamily: "Burmese"),
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
        await FilePicker.platform.pickFiles(allowMultiple: true);

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