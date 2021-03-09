
import 'package:flutter_module/wind/mvvm/base_view_model.dart';
import 'package:flutter_module/wind/pager/page_request.dart';
import 'package:flutter_module/wind/pager/page_response.dart';

abstract class PageViewModel<Req extends PageRequest,Resp extends PageResponse> extends BaseViewModel<Req,Resp>{
  bool loading=false;
  int page=0;
  Future<void> loadFirstPage(Req req) async{
    page=0;
    req.page=page;
    request(req);
    return null;
  }

  Future loadNextPage(Req req) async{
    page++;
    req.page=page;
    request(req);
  }
}