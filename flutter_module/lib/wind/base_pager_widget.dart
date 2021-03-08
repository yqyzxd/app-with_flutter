import 'package:flutter/material.dart';
import 'package:flutter_module/bean/paged_data.dart';
import 'package:flutter_module/wind/pager/page_list_response.dart';
import 'package:flutter_module/wind/pager/paged_data_response.dart';

import 'adapters.dart';
import 'http/base_response.dart';
import 'mvvm/base_view_model.dart';
import 'mvvm/page_view_model.dart';
import 'mvvm/view_model_holder.dart';
import 'offstage_appbar.dart';
import 'pager/page_request.dart';
import 'pager/page_response.dart';
import 'widget_loading.dart';

abstract class BasePagerState<VM extends PageViewModel> extends ViewModelHolder<StatefulWidget,VM>  {

  BaseDelegateAdapter adapter;
  PageViewModel pageViewModel;

  @override
  void initState() {
    super.initState();
    pageViewModel=viewModel;
    adapter=createAdapter();
    loadFirstPage();

  }
  PageRequest buildRequest(bool firstPage);

  void loadFirstPage(){
    pageViewModel.loadFirstPage(buildRequest(true));
  }
  void loadNextPage(){
    pageViewModel.loadNextPage(buildRequest(false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:OffstageAppBar(context),
      body: StreamBuilder(
        stream: viewModel.dataStream,
        builder: (BuildContext context,AsyncSnapshot<PageResponse> snapshot){
          return _showLoadingWidget(snapshot);
        },
      ),
    );


  }

  LoadingWidget _showLoadingWidget(AsyncSnapshot<PageResponse> snapshot) {
    int state=LoadingWidget.LOADING_STATE;
    if(snapshot.connectionState!=ConnectionState.waiting){
      state= snapshot.hasError?LoadingWidget.ERROR_STATE:LoadingWidget.CONTENT_STATE;
    }

    return LoadingWidget(
      content:state==LoadingWidget.CONTENT_STATE?buildContent(snapshot.data):Text('error'),
      state: state,
    );

  }


  BaseDelegateAdapter createAdapter();
  Widget buildDivider(){
    return Divider(height: 0.0);
  }


  Widget buildContent(PageResponse response) {
      bool firstPage = response.firstPage;
      List<DisplayItem> items=[];
      if(response.data is PagedData){
        items=(response.data as PagedData).datas;

      }else if(response.data is List){
        items = response.data;
      }

      if (firstPage==true) {
        adapter.replace(items);
      } else {
        adapter.addAll(items);
      }
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
      /*  if (i.isOdd) buildDivider();

        final index = i ~/ 2;*/
        if (index >= adapter.items.length) {
          //todo 加载更多
          bool hasMore=adapter.items.elementAt(adapter.items.length-1) is LoadingMoreItem;
          if(!hasMore){
            items.add(LoadingMoreItem());
          }
        }
        return buildRow(items.elementAt(index), index);
      });


  }

  Widget buildRow(DisplayItem item,int position){
    return adapter.onBuildWidget(position);
  }



}
