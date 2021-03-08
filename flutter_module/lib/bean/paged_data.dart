
import 'package:json_annotation/json_annotation.dart';


class PagedData<T>{

  int curPage;
  int pageCount;

  List<T> datas;


  PagedData({this.curPage, this.pageCount, this.datas});

  factory PagedData.fromJson(Map<String,dynamic> json){

    return PagedData(
      curPage: json['curPage'],
      pageCount: json['pageCount'],
      datas: json['datas'],
    );
  }


}