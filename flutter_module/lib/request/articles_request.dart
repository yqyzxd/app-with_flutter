
import 'package:flutter_module/wind/pager/page_request.dart';
import 'package:json_annotation/json_annotation.dart';
part 'articles_request.g.dart';


@JsonSerializable(explicitToJson: true)
class ArticlesRequest extends PageRequest{

  @override
  Map<String,dynamic> toJson(){
    return _$ArticlesRequestToJson(this);
  }

}