

import 'package:flutter/cupertino.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

import 'view_model_provider.dart';

abstract class ViewModelHolder<T extends StatefulWidget,VM extends BaseViewModel> extends State<T>{
  VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel=ViewModelProvider.of(context);
  }
}