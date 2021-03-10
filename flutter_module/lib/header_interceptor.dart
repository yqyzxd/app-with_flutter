
import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) {
    // TODO: implement onRequest

    Map<String,dynamic> headers=options.headers;
    if(headers == null){
      headers=new Map();
    }
    //获取公共headers

    //生成signature
    headers['Signature']=_generateSignature();

    options.headers=headers;
    return super.onRequest(options);
  }

  String _generateSignature(){
    return '';
  }

}