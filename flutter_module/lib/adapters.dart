import 'package:flutter/material.dart';

/**
 * adapter item bean
 */
abstract class DisplayItem {}

abstract class AdapteDelegate<T> {
  bool isForViewType(T item, int position);

  Widget onBuildWidget(T item, int position);
}

class AdapterDelegatesManager<T> {
  final _delegates = new Map<int,AdapteDelegate>();

  AdapterDelegatesManager<T> addDelegate(AdapteDelegate<T> delegate,
      [int viewType = 0]) {
    if (viewType == 0) {
      viewType = _delegates.length;
      while (_delegates[viewType] != null) {
        viewType++;
      }
    }

    if (_delegates[viewType] != null) {
      throw Exception(
          "An AdapterDelegate is already registered for the viewType = " +
              viewType.toString() +
              ". Already registered AdapterDelegate is " +
              _delegates[viewType].toString());
    }

    _delegates[viewType]=delegate;
    return this;
  }

  int getItemViewType(T item,int position){
    int delegatesCount = _delegates.length;
    for(int i=0;i<delegatesCount;i++){
      AdapteDelegate<T> delegate=_delegates.values.elementAt(i);
      if(delegate.isForViewType(item, position)){
          return _delegates.keys.elementAt(i);
      }
    }
    throw NullThrownError();
  }


  Widget onBuildWidget(T item,int position,int viewType){
    AdapteDelegate<T> delegate= getDelegateForViewType(viewType);
    return delegate.onBuildWidget(item, position);
  }

  AdapteDelegate<T> getDelegateForViewType(int viewType){
    AdapteDelegate<T> delegate=_delegates[viewType];
    return delegate;
  }
}

abstract class BaseDelegateAdapter{

  final manager=AdapterDelegatesManager<DisplayItem>();
  List<DisplayItem> items=<DisplayItem>[];

  BaseDelegateAdapter(){
    addDelegate();
  }
  void addDelegate();


  int getItemViewType(int position){
    return manager.getItemViewType(items[position], position);
  }

  Widget onBuildWidget(int position){
    return manager.onBuildWidget(items[position], position, getItemViewType(position));
  }

  int getItemCount(){
    return items.length;
  }

  void replace(List<DisplayItem> items){
    this.items=items;
  }
}

