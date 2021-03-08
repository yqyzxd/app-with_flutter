import 'package:flutter_module/wind/http/base_response.dart';
import '../adapters.dart';

abstract class PageListResponse<T extends DisplayItem> extends BaseResponse<List<T>>{

  bool firstPage;

  PageListResponse(List<T> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);




}