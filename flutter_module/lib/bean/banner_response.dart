import 'package:json_annotation/json_annotation.dart';
import '../http/base_response.dart';
import 'banner.dart';


part 'banner_response.g.dart';


@JsonSerializable(explicitToJson: true)
class BannerResponse extends BaseResponse<List<Banner>>{
  BannerResponse(List<Banner> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BannerResponse.fromJson(Map<String,dynamic> json)=>_$BannerResponseFromJson(json);

  @override
  Map<String,dynamic> toJson(){
    return _$BannerResponseToJson(this);
  }







}