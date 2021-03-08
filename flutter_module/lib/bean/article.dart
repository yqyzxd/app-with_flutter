
import 'package:flutter_module/wind/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';

@JsonSerializable()
class Article implements DisplayItem {


  String author;
  String link;
  String title;


  Article(this.author, this.link, this.title);

  factory Article.fromJson(Map<String,dynamic> json) =>_$ArticleFromJson(json);
  Map<String,dynamic> toJson()=>_$ArticleToJson(this);

}