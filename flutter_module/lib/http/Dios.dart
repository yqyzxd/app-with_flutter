import 'package:dio/dio.dart';

class Dios{
  Dio _dio;
  Dios._privasteConstructor(BaseOptions options){
    _dio=new Dio(options);
  }

  static Dios _sInstance;
  static Dios newInstance(BaseOptions options){
      if(_sInstance==null){
        _sInstance=Dios._privasteConstructor(options);
      }
      return _sInstance;
  }
  factory Dios.getInstance() => _sInstance;


}