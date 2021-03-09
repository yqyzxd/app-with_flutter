import 'package:flutter_module/bean/paged_data.dart';
import 'package:flutter_module/wind/adapters.dart';
import 'package:flutter_module/wind/http/base_response.dart';

class PagedDataResponse<T> extends BaseResponse<T>{

  bool firstPage;
  PagedDataResponse(T data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);


}