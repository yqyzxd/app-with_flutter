
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  static const int LOADING_STATE=0;
  static const int CONTENT_STATE=1;
  static const int ERROR_STATE=2;
  Widget content;
  Widget loading;
  Widget error;
  int state=LOADING_STATE;

  LoadingWidget({Key key,this.content,this.state = LOADING_STATE,this.loading,this.error}): assert(content!= null),super(key:key);

  @override
  Widget build(BuildContext context) {

    Widget child;
    switch(state){
      case LoadingWidget.LOADING_STATE:
        child=loading==null?CircularProgressIndicator():loading;
        break;
      case LoadingWidget.CONTENT_STATE:
        child=content;
        break;
      case LoadingWidget.ERROR_STATE:
        child=error==null?DefaultLoadingErrorWidget():error;
        break;
    }
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: child,
    );
  }

}


class CircularLoadingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class DefaultLoadingErrorWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(

    );
  }

}