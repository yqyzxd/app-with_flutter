import 'package:flutter_module/bean/article_paged_data.dart';
import 'package:flutter_module/wind/http/page_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'articles_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ArticlesResponse extends PageResponse<ArticlePagedData>{
  ArticlesResponse(ArticlePagedData data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);


  factory ArticlesResponse.fromJson(Map<String,dynamic> json)=>_$ArticlesResponseFromJson(json);


}