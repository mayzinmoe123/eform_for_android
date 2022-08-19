import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  final String name;
  final String email;

  const AccountHeader(this.name, this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(5),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white),
          //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
          // ),
          child: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 45,
          ),
        ),
        SizedBox(width: 5),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
