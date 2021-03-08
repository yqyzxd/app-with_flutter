import 'package:flutter/cupertino.dart';
import 'package:flutter_module/wind/http/base_response.dart';


abstract class ResponseState<T extends BaseResponse> extends State<StatefulWidget> {

  T reponse;
  setResponse(T response){
    setState(() {
      this.reponse=reponse;
    });
  }


}

