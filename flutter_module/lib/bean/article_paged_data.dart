import 'package:flutter_module/bean/article.dart';
import 'package:flutter_module/bean/paged_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_paged_data.g.dart';


@JsonSerializable(explicitToJson: true)
class ArticlePagedData extends PagedData<List<Article>>{
  ArticlePagedData(int curPage, int pageCount, List<Article> datas)
      : super(curPage, pageCount, datas);

  factory ArticlePagedData.fromJson(Map<String,dynamic> json) =>_$ArticlePagedDataFromJson(json);
  Map<String,dynamic> toJson()=>_$ArticlePagedDataToJson(this);


}