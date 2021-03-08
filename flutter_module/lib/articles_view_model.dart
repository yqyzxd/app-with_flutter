
import 'package:flutter_module/request/articles_request.dart';
import 'package:flutter_module/response/articles_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import 'wind/http/dios.dart';

class ArticlesViewModel extends BaseViewModel<ArticlesRequest,ArticlesResponse>{
  @override
  Future request(ArticlesRequest request) {

    return Dios.getInstance().get("/article/list/"+request.page.toString()+"/json", request.toJson(),(responseMap){
      final response=ArticlesResponse.fromJson(responseMap);
      print('dataObservable.add(response);');
      dataObservable.add(response);
    },(e){
      print('dataObservable.addError(e)  e.msg:'+  e.msg+ "e.code:"+e.code.toString());

      dataObservable.addError(e);
    });
  }


}