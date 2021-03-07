import 'package:flutter/material.dart';

import 'base_view_model.dart';


class ViewModelProvider<VM extends BaseViewModel> extends StatefulWidget {
  final VM viewModel;
  final Widget child;

  ViewModelProvider({this.viewModel, this.child});

  static VM of<VM extends BaseViewModel>(BuildContext context) {
    ViewModelProvider<VM> provider =
    context.findAncestorWidgetOfExactType<ViewModelProvider<VM>>();
    VM vm=provider.viewModel;
    vm.initViewMode();
    return vm;
  }

  @override
  State<StatefulWidget> createState() => _ViewModelProviderState();
}

class _ViewModelProviderState extends State<ViewModelProvider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.viewModel.initViewMode();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}