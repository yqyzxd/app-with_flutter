import 'package:flutter/material.dart';
import 'package:flutter_module/banner_view_model.dart';
import 'package:flutter_module/response/banner_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';
import 'package:flutter_module/wind/mvvm/view_model_holder.dart';
import 'package:flutter_module/wind/mvvm/view_model_provider.dart';
import 'package:flutter_module/wind/widget_loading.dart';
class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends ViewModelHolder<BannerPage,BannerViewModel>{


  @override
  void initState() {
    super.initState();

    viewModel.request();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BannerPager'),
      ),
      body: StreamBuilder(
        stream: viewModel.dataStream,
        builder: (BuildContext context,AsyncSnapshot<BannerResponse> snapshot){
          print('_showLoadingWidget'+snapshot.connectionState.toString());
          return _showLoadingWidget(snapshot);
        },
      ),
    );
  }



  LoadingWidget _showLoadingWidget(AsyncSnapshot<BannerResponse> snapshot) {
    int state=LoadingWidget.LOADING_STATE;
    switch(snapshot.connectionState){
      case ConnectionState.waiting:
        state=LoadingWidget.LOADING_STATE;
        break;
      case ConnectionState.done:
        state= snapshot.hasError?LoadingWidget.ERROR_STATE:LoadingWidget.CONTENT_STATE;
        break;
    }
    return LoadingWidget(
      content: Text("${snapshot.data}"),
      state: state,
    );
  }


}
