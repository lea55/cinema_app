import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.onPressed})
      : super(key: key);
  final String title;
  final String subtitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        margin: EdgeInsets.only(right: 48),
        child: ListTile(
          title: Text(
            this.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            this.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
            size: 17,
          ),
          onPressed: this.onPressed),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
