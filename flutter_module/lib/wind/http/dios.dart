import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';


typedef OnSuccess = void Function(Map<String,dynamic> json);
typedef OnError =void Function(ErrorBean error);

class Dios {
  Dio _dio;

  Dios._privasteConstructor(BaseOptions options) {
    _dio = new Dio(options);

  }
  void enabledLog(){
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }
  Dios addInterceptor(Interceptor interceptor){
    _dio.interceptors.add(interceptor);
    return _sInstance;
  }
  static Dios _sInstance;

  static Dios newInstance(BaseOptions options) {
    if (_sInstance == null) {
      _sInstance = Dios._privasteConstructor(options);
    }
    return _sInstance;
  }

  factory Dios.getInstance() => _sInstance;



  Future get(
      String path, Map<String,dynamic> requestParameters,OnSuccess onSuccess,  OnError onError) {
      //参数不填options时 ResponseType为json，r.data.toString()输出的json 子段没有双引号，导致 jsonDecode报错
      _dio.get(path,queryParameters:requestParameters,options:  Options(responseType: ResponseType.plain)).then((r) {
        if (r.statusCode == HttpStatus.ok) {
          //转化成 json
          //print("r.data.toString()  "+r.data.toString());
          Map<String,dynamic> map = jsonDecode(r.data.toString());
          onSuccess(map);
        } else {
          onError(ErrorBean(r.statusCode.toString(), r.statusCode));

        }
      }).catchError((e) => onError(ErrorBean(e.toString(), 500)));
  }

  Future post(
      String path, Map<String,dynamic> requestParameters,OnSuccess onSuccess,  OnError onError) {
    //build queryParameters

    _dio.post(path, queryParameters: requestParameters,options:  Options(responseType: ResponseType.plain)).then((r) {
      if (r.statusCode == HttpStatus.ok) {
        //转化成 json
        Map<String,dynamic> map= jsonDecode(r.data.toString());
        onSuccess(map);
      } else {
        onError(ErrorBean("", r.statusCode));
      }
    }).catchError((e) => onError(ErrorBean(e.toString(), 500)));
  }


}

class ErrorBean {
  String msg;
  int code;

  ErrorBean(this.msg, this.code);
}


