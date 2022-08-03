import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Money extends StatefulWidget {
  const Money({Key? key}) : super(key: key);

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ကောက်ခံမည့်နှုန်းများ"),
      ),
      body: Table(
        border: TableBorder.all(
          color: Colors.black,
        ),
        children: [
          TableRow(children: [
            Text("အကြောင်းအရာများ"),
            Text("ကောက်ခံရမည့်နှုန်းထား (ကျပ်)"),
          ])
        ],
      ),
    );
  }
}
