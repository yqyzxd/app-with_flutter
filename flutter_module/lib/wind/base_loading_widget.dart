import 'package:flutter/material.dart';
import 'package:flutter_module/wind/http/base_request.dart';
import 'package:flutter_module/wind/http/base_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import 'mvvm/view_model_holder.dart';
import 'response_state.dart';
import 'widget_loading.dart';

/**
 * 用于页面加载
 */
abstract class BaseLoadingWidgetState<VM extends BaseViewModel,Resp extends BaseResponse> extends ViewModelHolder<StatefulWidget,VM> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.request(buildRequest());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page'),
      ),
      body: StreamBuilder(
        stream: viewModel.dataStream,
        builder: (BuildContext context,AsyncSnapshot<BaseResponse> snapshot){
          return _showLoadingWidget(snapshot);
        },
      ),
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

  Widget buildContent(Resp response);

  BaseRequest buildRequest();
}
