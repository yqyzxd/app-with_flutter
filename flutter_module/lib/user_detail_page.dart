import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_module/offstage_appbar.dart';
import 'widget_loading.dart';
import 'package:flutter_module/mu_notify.dart';
import 'package:flutter_module/flutter_initializer.dart';


class UserDetailPage extends StatefulWidget {
  UserDetailPage() {
    FlutterInitializer.init();
  }

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  int state = LoadingWidget.CONTENT_STATE;

  @override
  void initState() {
    super.initState();
    /*final bannerRequest = BannerRequest();
    Future.delayed(Duration(milliseconds: 1500), () {
      Dios.getInstance().get("/banner/json", bannerRequest.toJson(),
          (responseMap) {
        final response = BannerResponse.fromJson(responseMap);
        setState(() {
          state = LoadingWidget.CONTENT_STATE;
        });
      }, (e) {
        setState(() {
          state = LoadingWidget.ERROR_STATE;
        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(state),
    );
  }
}


class HomePage extends StatelessWidget{
  int state;
  HomePage(this.state);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:OffstageAppBar(context),
      body: LoadingWidget(
        content: MsgNotificationSettingWidget(),
        state: state,
      ),
    );
  }

}