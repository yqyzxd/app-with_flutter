
import 'package:flutter_module/response/banner_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import 'request/banner_request.dart';
import 'wind/http/dios.dart';

class BannerViewModel extends BaseViewModel<BannerRequest,BannerResponse>{


  @override
  Future request(BannerRequest request) {
    return Dios.getInstance().get("/banner/json", request.toJson(),(responseMap){
      final response=BannerResponse.fromJson(responseMap);
      print('dataObservable.add(response);');
      dataObservable.add(response);
    },(e){
      print('dataObservable.addError(e);');
      dataObservable.addError(e);
    });
  }




}