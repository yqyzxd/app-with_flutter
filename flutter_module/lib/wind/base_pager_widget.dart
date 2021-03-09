import 'package:flutter/material.dart';
import 'package:flutter_module/bean/paged_data.dart';
import 'adapter/adapters.dart';
import 'http/page_response.dart';
import 'mvvm/page_view_model.dart';
import 'mvvm/view_model_holder.dart';
import 'offstage_appbar.dart';
import 'http/page_request.dart';
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

  Future<void> loadFirstPage() async{
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
    return Divider(height: 1);
  }


  Widget buildContent(PageResponse response) {
      bool firstPage = response.firstPage;
      List<DisplayItem> items=[];
      if(response.data is PagedData){
        items.addAll((response.data as PagedData).datas);

      }else if(response.data is List){
        items.addAll(response.data);
      }
      //删除adapter中的加载更多
      if(adapter.items.length>0) {
        bool hasMore = adapter.items.elementAt(
            adapter.items.length - 1) is LoadingMoreItem;
        if (hasMore == true) {
          adapter.remove(adapter.items[adapter.items.length - 1]);
        }
      }

      if (firstPage==true) {
        adapter.replace(items);
      } else {
        adapter.addAll(items);
      }


      return RefreshIndicator(
        child: _buildListView(),
        onRefresh: loadFirstPage,
      );


  }

  ListView _buildListView(){
    return ListView.separated(
        itemCount: adapter.items.length+1, //列表项的数量，如果为null，则为无限列表
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) {
          /*  if (i.isOdd) buildDivider();

        final index = i ~/ 2;*/
          if (index >= adapter.items.length) {
            //todo 加载更多
            loadNextPage();
            bool hasMore=adapter.items.elementAt(adapter.items.length-1) is LoadingMoreItem;
            if(!hasMore){
              adapter.items.add(LoadingMoreItem());
            }
          }
          //print("ListView.builder index:"+index.toString());
          return buildRow(adapter.items.elementAt(index), index);
        });
  }

  Widget buildRow(DisplayItem item,int position){
    return adapter.onBuildWidget(position);
  }



}
