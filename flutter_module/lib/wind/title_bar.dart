import 'package:flutter/material.dart';

class TitlerBar extends StatelessWidget {
  final String title;
  final Color titleColor;

  final Widget right;

  TitlerBar(this.title, {this.titleColor, this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      height: 56,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('icons/icon_titlebar_white_back.png'),
            ),
          ),
          Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title == null ? '' : title,
                  style: TextStyle(
                      color: titleColor == null ? Colors.black : titleColor,
                      fontSize: 16),
                ),
              )),
          Container(
            margin: EdgeInsets.only(right: 14),
            child: Align(
                alignment: Alignment.centerRight,
                child: right == null ? Text('') : right),
          )
        ],
      ),
    );
  }
}
