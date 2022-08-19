import 'package:flutter/material.dart';

class AccountLink extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback _onTap;

  const AccountLink(this.icon, this.text, this._onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        splashColor: Colors.lightBlueAccent,
        onTap: _onTap,
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(text),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.black45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
