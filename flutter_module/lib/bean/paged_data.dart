
import 'package:json_annotation/json_annotation.dart';


class PagedData<T>{

  int curPage;
  int pageCount;

  T datas;

  PagedData(this.curPage, this.pageCount, this.datas);
}