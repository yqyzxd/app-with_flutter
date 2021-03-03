import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter_module/http/base_request.dart';
import 'package:flutter_module/http/base_response.dart';

typedef OnSuccess<BR> = void Function(BR reponse);
typedef OnError =void Function(ErrorBean error);

class Dios {
  Dio _dio;

  Dios._privasteConstructor(BaseOptions options) {
    _dio = new Dio(options);
    _dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }

  static Dios _sInstance;

  static Dios newInstance(BaseOptions options) {
    if (_sInstance == null) {
      _sInstance = Dios._privasteConstructor(options);
    }
    return _sInstance;
  }

  factory Dios.getInstance() => _sInstance;



  void get<BR extends BaseResponse>(
      String path, BaseRequest request,OnSuccess<BR> onSuccess,  OnError onError) {
      _dio.get(path).then((r) {
        if (r.statusCode == HttpStatus.ok) {
          //转化成 json
          print(r.data.toString());
          Map<String,dynamic> map = jsonDecode(r.data.toString());


          //onSuccess(br.fromJson(map));
        } else {
          onError(ErrorBean(r.statusCode.toString(), r.statusCode));

        }
      }).catchError((e) => onError(ErrorBean(e.toString(), 500)));
  }

  void post<BR extends BaseResponse>(
      String path, BaseRequest request,OnSuccess onSuccess,  OnError onError) {
    //build queryParameters
    Map<String, dynamic> queryParameters = Map();
    _dio.post(path, queryParameters: queryParameters).then((r) {
      if (r.statusCode == HttpStatus.ok) {
        //转化成 json
        BR response = jsonDecode(r.data.toString());
        onSuccess(response);
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

abstract class OnLoadListener<BR extends BaseResponse> {
  void onLoadSuccess(BR reponse);

  void onError(ErrorBean error);
}
