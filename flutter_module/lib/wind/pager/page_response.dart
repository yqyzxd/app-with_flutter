import 'package:flutter_module/wind/http/base_response.dart';

class PageResponse<T> extends BaseResponse<T>{
  PageResponse(T data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

}