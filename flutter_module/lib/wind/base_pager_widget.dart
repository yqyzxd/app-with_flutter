import 'package:flutter/material.dart';
import 'package:flutter_module/wind/pager/page_list_response.dart';
import 'package:flutter_module/wind/pager/paged_data_response.dart';

import 'adapters.dart';
import 'http/base_response.dart';
import 'mvvm/base_view_model.dart';
import 'mvvm/view_model_holder.dart';
import 'pager/page_request.dart';
import 'widget_loading.dart';

abstract class BasePagerState<VM extends BaseViewModel,Resp extends BaseResponse> extends ViewModelHolder<StatefulWidget,VM>  {

  BaseDelegateAdapter adapter;



  @override
  void initState() {
    super.initState();
    adapter=createAdapter();
    loadFirstPage();

  }
  PageRequest buildRequest(bool firstPage);

  void loadFirstPage(){
    PageRequest request= buildRequest(true);
    viewModel.request(request);
  }
  void loadNextPage(){
    PageRequest request= buildRequest(false);
    viewModel.request(request);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: viewModel.dataStream,
      builder: (BuildContext context,AsyncSnapshot<BaseResponse> snapshot){
        return _showLoadingWidget(snapshot);
      },
    );
  }

  LoadingWidget _showLoadingWidget(AsyncSnapshot<BaseResponse> snapshot) {
    int state=LoadingWidget.LOADING_STATE;
    if(snapshot.connectionState!=ConnectionState.waiting){
      state= snapshot.hasError?LoadingWidget.ERROR_STATE:LoadingWidget.CONTENT_STATE;
    }

    return LoadingWidget(
      content:buildContent(snapshot.data),
      state: state,
    );

  }


  BaseDelegateAdapter createAdapter();
  Widget buildDivider(){
    return Divider(height: 0.0);
  }


  Widget buildContent(BaseResponse response) {
    bool firstPage=true;
    List<DisplayItem> items=[];
    if(response is PageListResponse){
      firstPage=response.firstPage;
      items=response.data;
    }else if(response is PagedDataResponse){
      firstPage=response.firstPage;
      items=response.data.datas;
    }
    if(firstPage) {
      adapter.replace(items);
    }else{
      adapter.addAll(items);
    }
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) buildDivider();

      final index = i ~/ 2;
      if (index >= adapter.items.length) {
        //todo 加载更多
      } else {
        return buildRow(response.data.elementAt(index),index);
      }
    });

  }

  Widget buildRow(DisplayItem item,int position){
    return adapter.onBuildWidget(position);
  }



}
