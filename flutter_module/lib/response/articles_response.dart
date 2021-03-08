
import 'package:flutter_module/bean/article.dart';
import 'package:flutter_module/bean/paged_data.dart';
import 'package:flutter_module/wind/adapters.dart';
import 'package:flutter_module/wind/pager/page_list_response.dart';
import 'package:flutter_module/wind/pager/paged_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articles_response.g.dart';


@JsonSerializable(explicitToJson: true)
class ArticlesResponse extends PagedDataResponse<Article>{
  ArticlesResponse(PagedData<Article> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);


  factory ArticlesResponse.fromJson(Map<String,dynamic> json)=>_$ArticlesResponseFromJson(json);


}