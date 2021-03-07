import 'package:flutter/material.dart';

import 'pager/page_request.dart';
import 'widget_loading.dart';

abstract class BasePager extends StatefulWidget {

  @override
  BasePagerState createState();
}

abstract class BasePagerState extends State<BasePager> {
  int state =LoadingWidget.LOADING_STATE;
  @override
  void initState() {
    super.initState();

    loadFirstPage();

  }
  PageRequest buildRequest(bool firstPage);

  void loadFirstPage(){
    PageRequest request= buildRequest(true);

    //todo 执行请求

  }
  void loadNextPage(){
    PageRequest request= buildRequest(false);

  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
        content: buildContentWidget(context),
        state: state,
    );
  }

  Widget buildContentWidget(context);

}
