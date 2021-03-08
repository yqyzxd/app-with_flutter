import 'package:flutter/material.dart';
import 'package:flutter_module/banner_view_model.dart';
import 'package:flutter_module/response/banner_response.dart';
import 'package:flutter_module/wind/base_loading_widget.dart';
import 'package:flutter_module/wind/http/base_request.dart';
import 'package:flutter_module/wind/http/base_response.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';
import 'package:flutter_module/wind/mvvm/view_model_holder.dart';
import 'package:flutter_module/wind/mvvm/view_model_provider.dart';
import 'package:flutter_module/wind/widget_loading.dart';

import 'request/banner_request.dart';

class BannerPage2 extends StatefulWidget {
  @override
  _BannerPage2State createState() => _BannerPage2State();
}

class _BannerPage2State
    extends BaseLoadingWidgetState<BannerViewModel, BannerResponse> {


  @override
  Widget buildContent(BannerResponse response) {
    return Text(response.toJson().toString());
  }

  @override
  BaseRequest buildRequest() {
    return BannerRequest();
  }
}
