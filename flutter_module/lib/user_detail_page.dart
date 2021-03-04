
import 'dart:io';

import 'package:flutter/material.dart';
import 'widget_loading.dart';
import 'package:flutter_module/mu_notify.dart';
import 'package:flutter_module/flutter_initializer.dart';
import 'package:flutter_module/request/banner_request.dart';
import 'response/banner_response.dart';
import 'package:flutter_module/http/dios.dart';
class UserDetailPage extends StatefulWidget {
  UserDetailPage(){
    FlutterInitializer.init();
  }
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  int state =LoadingWidget.LOADING_STATE;
  @override
  void initState() {
    super.initState();
    final bannerRequest=BannerRequest();
    Future.delayed(Duration(milliseconds: 1500), () {
      Dios.getInstance().get("/banner/json", bannerRequest.toJson(),(responseMap){
        final response=BannerResponse.fromJson(responseMap);
        setState(() {
          state =LoadingWidget.CONTENT_STATE;
        });
      },(e){
        setState(() {
          state =LoadingWidget.ERROR_STATE;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      theme: ThemeData(primaryColor: Colors.white),
      home:LoadingWidget(
        content: MsgNotificationSettingWidget(),
        state: state,
      ),//RandomWords(),
    );

  }
}
