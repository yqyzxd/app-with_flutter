
import 'package:flutter_module/response/banner_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import 'request/banner_request.dart';
import 'wind/http/dios.dart';

class BannerViewModel extends BaseViewModel<BannerResponse>{


  @override
  Future request() {
    final bannerRequest=BannerRequest();
    return Dios.getInstance().get("/banner/json", bannerRequest.toJson(),(responseMap){
      final response=BannerResponse.fromJson(responseMap);
      dataObservable.add(response);
    },(e){
      dataObservable.addError(e);
    });
  }




}