import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelPage extends StatefulWidget {
  @override
  _MethodChannelPageState createState() => _MethodChannelPageState();
}

class _MethodChannelPageState extends State<MethodChannelPage> {
  static const platform = const MethodChannel('com.wind/app_info');

  String text="...";
  @override
  void initState() {
    super.initState();

    _getHttpHeaders();
  }

  Future<Null> _getHttpHeaders() async {
    String t='not get';
    try {
      final Map<dynamic, dynamic> result =
          await platform.invokeMethod("getHttpHeaders");
      t=result['token'];
    }catch (e) {
      t='error';
    }
    setState(() {
      text=t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
