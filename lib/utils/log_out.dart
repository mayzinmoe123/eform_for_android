import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _asyncConfirmDialog(context);
      },
      child: Text("Logout"),
    );
  }

  Future<Future<ConfirmAction?>> _asyncConfirmDialog(
      BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout?',
            style: TextStyle(fontSize: 16.0),
          ),
          content: const Text('Are you sure to logout?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text(
                'LOGOUT',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                acceptConfirmBox(context);
                // _showSnackBar(context,'Sevice item is successfully deleted');
              },
            )
          ],
        );
      },
    );
  }

  void acceptConfirmBox(BuildContext context) async {
    Navigator.of(context).pop(ConfirmAction.ACCEPT);
    loggingOut();
  }

  void loggingOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    setState(() {
      pref.clear();
      pref.commit();
    });
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }
}
