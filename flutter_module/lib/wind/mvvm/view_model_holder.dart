

import 'package:flutter/cupertino.dart';
import 'package:flutter_module/wind/mvvm/base_view_model.dart';

abstract class ViewModelHolder<VM extends BaseViewModel> {
  VM get viewModel;
}