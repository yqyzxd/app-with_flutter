import 'package:flutter/material.dart';
import 'package:flutter_module/wind/http/base_request.dart';
import 'package:flutter_module/wind/http/base_response.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel<Req extends BaseRequest,Resp extends BaseResponse>{
  _StateLifecycle _lifecycleState=_StateLifecycle.created;


  BehaviorSubject<Resp> dataObservable = BehaviorSubject();
  Stream<Resp> get dataStream => dataObservable.stream;
  @protected
  @mustCallSuper
  void initViewMode(){
    assert(_lifecycleState==_StateLifecycle.created);
    _lifecycleState=_StateLifecycle.initialized;
  }

  Future request(Req request);

  void dispose(){
    assert(_lifecycleState==_StateLifecycle.initialized);
    _lifecycleState=_StateLifecycle.defunct;
    if(!dataObservable.isClosed) {
      dataObservable.close();
    }
  }
}



/// Tracks the lifecycle of [State] objects when asserts are enabled.
enum _StateLifecycle {
  /// The [State] object has been created. [State.initState] is called at this
  /// time.
  created,

  /// The [State.initState] method has been called but the [State.dispose] method has been not called.
  initialized,



  /// The [State.dispose] method has been called and the [State] object is
  /// no longer able to build.
  defunct,
}