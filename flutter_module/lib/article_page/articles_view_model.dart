import 'dart:async';

import 'package:flutter_module/request/articles_request.dart';
import 'package:flutter_module/response/articles_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import '../wind/http/dios.dart';
import '../wind/mvvm/page_view_model.dart';

class ArticlesViewModel
    extends PageViewModel<ArticlesRequest, ArticlesResponse> {

  @override
  Future request(ArticlesRequest request) async {
    Dios.getInstance().get(
        "/article/list/" + request.page.toString() + "/json", request.toJson(),
        (responseMap) {
      final response = ArticlesResponse.fromJson(responseMap);
      print('dataObservable.add(response);');
      return dataObservable.add(response);
    }, (e) {
      print('dataObservable.addError(e)  e.msg:' +
          e.msg +
          "e.code:" +
          e.code.toString());

      return dataObservable.addError(e);
    });
  }
}
