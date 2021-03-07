

import 'package:flutter_module/wind/http/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
part 'banner_request.g.dart';


@JsonSerializable(explicitToJson: true)
class BannerRequest extends BaseRequest{


  @override
  Map<String,dynamic> toJson(){
    return _$BannerRequestToJson(this);
  }
}