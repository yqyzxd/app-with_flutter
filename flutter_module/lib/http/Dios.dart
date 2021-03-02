import 'package:dio/dio.dart';

class Dios{

  Dios._privasteConstructor(BaseOptions options){

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