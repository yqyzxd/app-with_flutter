import 'package:dio/dio.dart';

import 'wind/http/dios.dart';


class FlutterInitializer{

  static void init(){
    BaseOptions options=new BaseOptions(
      baseUrl: "https://www.wanandroid.com",
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    Dios.newInstance(options).enabledLog();
  }
}